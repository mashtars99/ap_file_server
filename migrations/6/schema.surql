
// change return fn::edit_svd($svd_id, $name_ar, $name_eng, $addr); to change focal person as well
define function overwrite fn::edit_svd(
    $svd_id: record<saudi_visas_document>,
    $name_arabic: string,
    $name_english: string,
    $addr: string,
    $fp: record<focal_person>,
){
    let $svd = select * from only $svd_id;

    if(!$svd){
        throw "invalid request";
    };

    let $svd_updated = update only $svd_id merge {
        sponsor_name_arabic: $name_arabic,
        sponsor_name_english: $name_english,
        sponsor_address: $addr,
        focal_person: $fp,
    };

    return fn::get_full_svd($svd_updated.id);
};




// add account transfer function
define function overwrite fn::add_bank_transfer(
    $from_account_id: record<bank_account>,
    $to_account_id: record<bank_account>,
    $date: string,
    $ref: string,
    $desc: string,
    $amount: int,
){
    let $from_asset_account = select value asset_account from only $from_account_id;
    let $to_asset_account = select value asset_account from only $to_account_id;


    if(!$from_asset_account || !$to_asset_account){
        throw "invalid request";
    };

    
    if($from_account_id == $to_account_id){
        throw "same from and to accounts";
    };

    let $tx = create only transaction content{
        created_at: fn::utils::now(),
        date: <datetime>$date,
        type: "bank_transfer"
        
    };


    // from 
    let $from_res = create only gl_account_entry content {
		account: $from_asset_account,
		decr: $amount,
		description: $desc,
		incr: 0,
		reference: $ref,
		transaction: $tx.id
	};

    // to

    let $to_res = create only gl_account_entry content {
		account: $to_asset_account,
		decr: 0,
		description: $desc,
		incr: $amount,
		reference: $ref,
		transaction: $tx.id
	};

    return {
        "from": $from_res,
        "to": $to_res,
    };
};

// customer statuement
define function overwrite fn::reporting::customer_statement(
    $std: string,
    $edt: string,
    $customer: record<entity>,
){



    let $startDate = time::floor(<datetime>$std, 1d);
    let $endDate = time::floor(<datetime>$edt, 1d);

    
    let $customer = select * from only $customer;
    let $account = $customer.account;
    
    return select *, transaction.* as tx from sl_account_entry 
        where account=$account and
            time::floor(transaction.date, 1d) >= $starDate and
            time::floor(transaction.date, 1d) <= $endDate
        order by tx.date asc;

};

// vendor statemnt
define function overwrite fn::reporting::vendor_statement(
    $std: string,
    $edt: string,
    $vendor_id: record<entity>,
){

    
    let $startDate = time::floor(<datetime>$std, 1d);
    let $endDate = time::floor(<datetime>$edt, 1d);

    
    let $vendor = select * from only $vendor_id;
    let $account = $vendor.account;
    
    return select *, transaction.* as tx from sl_account_entry 
        where account=$account and
            time::floor(transaction.date, 1d) >= $starDate and
            time::floor(transaction.date, 1d) <= $endDate
        order by tx.date asc;

};


// change order of sale and purchase

define function overwrite fn::accounting::sell_item(
    $entity_id: record<entity>,
    $item_id: record<item>,
    $sales_details: object,
    $purchase_details: option<object|null>,
    $date: string,
){

    let $item = select * from only $item_id;
    let $entity = select * from only $entity_id;

    if !$item or !$entity{
        throw "invalid reqeust";
    };

    if($purchase_details){
        fn::accounting::purchase_item(
            $purchase_details.item_id,
            $purchase_details,
            type::string($date),
        );
    };

    let $tx = create only transaction content {
        type: "sale",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };

    // item
    create only gl_account_entry content{
        account: $item.income_account,
        description: $sales_details.description,
        reference: $sales_details.reference,
        incr: <int>$sales_details.amount,
        decr: 0,
        transaction: $tx.id,
    };

    create only sl_account_entry content{
        account: $entity.account,
        description: $sales_details.description,
        reference: $sales_details.reference,
        incr: <int>$sales_details.amount,
        decr: 0,
        transaction: $tx.id,
    };
    
};