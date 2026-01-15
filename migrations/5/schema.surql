define function overwrite fn::accounting::add_sales_return(
    $entity_id: record<entity>,
    $item_id: record<item>,
    $details: object,
    $date: string,
){

    let $entity = select * from only $entity_id;
    if(!$entity){
        throw "invalid entity";
    };

    let $item = select * from only $item_id;
    if(!$item){
        throw "invalid item";
    };


    let $tx = create only transaction content {
        type: "sales_return",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };

    // entity
    let $entry = create only sl_account_entry content {
        account: $entity.account,
        incr: 0,
        decr: <int>$details.amount,
        description: $details.description,
        reference: $details.reference,
        transaction: $tx.id,
    };


    //income
    create only gl_account_entry content {
        account: $item.contra_income_account,
        incr: <int>$details.amount,
        decr: 0,
        description: $details.description,
        reference: $details.reference,
        transaction: $tx.id,
    };
    
    return $entry;
    
};


define function overwrite fn::accounting::add_purchase_return(
    $entity_id: record<entity>,
    $item_id: record<item>,
    $details: object,
    $date: string,
){

    let $entity = select * from only $entity_id;
    if(!$entity){
        throw "invalid entity";
    };

    let $item = select * from only $item_id;
    if(!$item){
        throw "invalid item";
    };


    let $tx = create only transaction content {
        type: "purchase_return",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };

    // entity
    let $entry = create only sl_account_entry content {
        account: $entity.account,
        incr: <int>$details.amount,
        decr: 0,
        description: $details.description,
        reference: $details.reference,
        transaction: $tx.id,
    };


    //income
    create only gl_account_entry content {
        account: $item.contra_cogs_account,
        incr: <int>$details.amount,
        decr: 0,
        description: $details.description,
        reference: $details.reference,
        transaction: $tx.id,
    };
    
    return $entry;
    
};




define function overwrite fn::reporting::income_statement($start: string, $end: string){

    let $start_date = time::floor(<datetime>$start, 1d);
    let $end_date = time::floor(<datetime>$end,1d);

    // operating revenue
    let $income_accounts = select value income_account from item;

    // income
    let $income_sum = select account, math::sum(incr-decr) as total
            from gl_account_entry 
                where account in $income_accounts and
                    time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
            group by account;
    
    $income_sum = array::map($income_sum, |$val| $val.total);
    
    let $income_total = math::sum($income_sum);

    //--------end income------------


    // contra income
    let $contra_income_accounts = select value contra_income_account from item;

    let $contra_income_sum = select account, math::sum(incr-decr) as total
            from gl_account_entry 
                where account in $contra_income_accounts and
                    time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
            group by account;
    
    $contra_income_sum = array::map($contra_income_sum, |$val| $val.total);
    
    let $contra_income_total = math::sum($contra_income_sum);

    // ------end contra income-------


    // cogs
    let $cogs_accounts = select value cogs_account from item;
    
    $cogs_sum = select account, math::sum(incr-decr) as total
                  from gl_account_entry 
                    where account in $cogs_accounts and
                     time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
                    group by account;
    
    $cogs_sum = array::map($cogs_sum, |$val| $val.total);
    
    let $cogs_total = math::sum($cogs_sum);

    // -----end cogs-------


    // contra cogs
    let $contra_cogs_accounts = select value contra_cogs_account from item;
    
    $contra_cogs_sum = select account, math::sum(incr-decr) as total
                  from gl_account_entry 
                    where account in $contra_cogs_accounts and
                     time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
                    group by account;
    
    $contra_cogs_sum = array::map($contra_cogs_sum, |$val| $val.total);
    
    let $contra_cogs_total = math::sum($contra_cogs_sum);

    // -----end contra cogs-------
    

    return {
        "revenue": $income_total,
        "contra_income": $contra_income_total,
        "cogs": $cogs_total,
        "contra_cogs": $contra_cogs_total,
    };
    
};



define function overwrite fn::reporting::item_wise_income_statement($start: string, $end: string){
    let $start_date = time::floor(<datetime>$start, 1d);
    let $end_date = time::floor(<datetime>$end,1d);

let $data = select name, income_account, transaction,
    
    (
        select account, math::sum(incr - decr) as total from only gl_account_entry where account =  $parent.income_account and
    time::floor(transaction.date, 1d) >= $start_date and
    time::floor(transaction.date, 1d) <= $end_date
        group by account
        
    ) as revenue,

        (
        select account, math::sum(incr - decr) as total from only gl_account_entry where account =  $parent.contra_income_account and
    time::floor(transaction.date, 1d) >= $start_date and
    time::floor(transaction.date, 1d) <= $end_date
        group by account
        
    ) as contra_income,

(
        select account, math::sum(incr - decr) as total from only gl_account_entry where account =  $parent.cogs_account  and
    time::floor(transaction.date, 1d) >= $start_date and
    time::floor(transaction.date, 1d) <= $end_date
        group by account
        
    ) as cogs,

(
        select account, math::sum(incr - decr) as total from only gl_account_entry where account =  $parent.contra_cogs_account  and
    time::floor(transaction.date, 1d) >= $start_date and
    time::floor(transaction.date, 1d) <= $end_date
        group by account
        
    ) as contra_cogs

from item;

    return array::map($data, |$v| {
        {name: $v.name, revenue: $v.revenue.total??0, cogs: $v.cogs.total??0,
        contra_income: $v.contra_income.total??0, contra_cogs: $v.contra_cogs.total??0}
    });
};

