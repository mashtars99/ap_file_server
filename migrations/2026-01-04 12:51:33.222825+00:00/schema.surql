
// ================================= ACCOUNTING ================================

# gl accounts
define table gl_account type normal schemaless permissions full;
define field name on gl_account type string assert string::len($value)>1;
define field meta on gl_account type option<object> default {};
define field type on gl_account type string
    assert $value in ["asset", "liability", "equity", "income", "expense",
        "contra_asset", "contra_liability","contra_equity", "contra_income", "contra_expense"];
define field balance on gl_account type int default 0;

define index unique_name_type on gl_account fields name, type unique;

define table gl_subaccount_of type relation from gl_account to gl_account permissions full;


define table gl_account_entry type normal schemaless permissions full;
define field account on gl_account_entry type record<gl_account>;
define field incr on gl_account_entry type int;
define field decr on gl_account_entry type int;
define field description on gl_account_entry type string default "";
define field reference on gl_account_entry type string default "";
define field transaction on gl_account_entry type record<transaction>;




DEFINE EVENT overwrite update_gl_account_on_entry_creation ON TABLE gl_account_entry
    WHEN $event = "CREATE"
    THEN {
        -- Check if the post allows for adding comments.
        -- User record doesn't have access to the `post` table.
        IF $after.incr > 0 {
            update $after.account set balance = balance + $after.incr;
        };

        IF $after.decr > 0 {
            update $after.account set balance = balance - $after.decr;
        };
};


DEFINE EVENT overwrite update_gl_account_on_entry_deletion ON TABLE gl_account_entry
    WHEN $event = "DELETE"
    THEN {
        -- Reverse the balance adjustments when a gl_account_entry is deleted.
        IF $before.incr > 0 {
            UPDATE $before.account SET balance = balance - $before.incr;
        };

        IF $before.decr > 0 {
            UPDATE $before.account SET balance = balance + $before.decr;
        };
    };





define table sl_account type normal schemaless permissions full;     // sl = subsidiary ledger
define field balance on sl_account type int default 0;
define field meta on sl_account type option<object> default {};


define table sl_account_entry type normal schemaless permissions full;
define field account on sl_account_entry type record<sl_account>;
define field incr on sl_account_entry type int;
define field decr on sl_account_entry type int;
define field description on sl_account_entry type string;
define field reference on sl_account_entry type string;
define field transaction on sl_account_entry type record<transaction>;
define field ulid on sl_account_entry type option<string> default rand::ulid();


DEFINE EVENT overwrite update_sl_account_on_entry_creation ON TABLE sl_account_entry
    WHEN $event = "CREATE"
    THEN {
        -- Check if the post allows for adding comments.
        -- User record doesn't have access to the `post` table.
        IF $after.incr > 0 {
            update $after.account set balance = balance + $after.incr;
        };

        IF $after.decr > 0 {
            update $after.account set balance = balance - $after.decr;
        };
};

DEFINE EVENT overwrite update_sl_account_on_entry_deletion ON TABLE sl_account_entry
    WHEN $event = "DELETE"
    THEN {
        -- Reverse the balance adjustments when a gl_account_entry is deleted.
        IF $before.incr > 0 {
            UPDATE $before.account SET balance = balance - $before.incr;
        };

        IF $before.decr > 0 {
            UPDATE $before.account SET balance = balance + $before.decr;
        };
    };



/*

type: [
    "purchase", "sale", "payment_made", "payment_received", expense
]

*/

define table transaction type normal schemaless permissions full;
define field type on transaction type string;
define field created_at on transaction type datetime;
define field date on transaction type datetime;



define table country type normal schemaless permissions full;
define field name on country type string;
define field code on country type string;
define field currency on country type string;
define field language on country type string;



// ========= POS Schema=================

define table entity type normal schemaless permissions full;
define field overwrite name on entity type string assert string::len($value) >4 ;
define field address on entity type option<string>;
define field contacts on entity type option<array<string>> default [];
define field picture on entity type option<string|null>;
define field status on entity type string 
    assert $value in ["active", "inactive"] default "active";
define field type on entity type string assert $value in ["customer", "vendor"];
define field account on entity type record<sl_account>;


define table ticket type normal schemaless permissions full;
define field pnr on ticket type string;
define field passengers on ticket type array<object>;
define field sectors on ticket type array<object>;
define field created_at on ticket type datetime default time::now();
define field refunded on ticket type bool default false;





//  items
define table item type normal schemaless permissions full;
define field is_service on item type bool default false;
define field name on item type string;
define field purchase_description on item type string default "";
define field sale_description on item type string default "";
define field asset_account on item type record<gl_account>;
define field income_account on item type record<gl_account>;
define field contra_income_account on item type record<gl_account>;
define field cogs_account on item type record<gl_account>;
define field contra_cogs_account on item type record<gl_account>;


define table task type normal schemaless permissions full;
define field name on task type string assert string::len($value)>0;
define field description on task type string;
define field deadline on task type datetime;
define field category on task type record<task_category>;
define field last_critical_days on task type int;
define field meta on task type object;


// banking

define table bank type normal schemaless permissions full;
define field abbr on bank type option<string|null>;
define field name on bank type string;


define table bank_account type normal schemaless permissions full;
define field bank on bank_account type record<bank>;
define field title on bank_account type string;
define field account_no on bank_account type string;
define field iban on bank_account type option<string|null>;
define field asset_account on bank_account type record<gl_account>;



// FILES
define table file schemaless type normal permissions full;
define field identifier on file type string;
define field metadata on file type object;
define field folder on file type record<folder>;
define field name on file type string;


define table folder schemaless type normal permissions full;
define field name on folder type string;

-- define table folder_contains schemaless type relation from folder to file permissions full;
define table folder_belongs_to schemaless type relation permissions full;

// visa process


define table saudi_visa_process type normal schemaless permissions full;
define field profile on saudi_visa_process type record<candidate_profile>;
define field assigned_job on saudi_visa_process type record<svp_assigned_job>;
define field svd on saudi_visa_process type record<saudi_visas_document>;
define field status on saudi_visa_process type option<string> default "active" assert $value in["active",  "completed", "cancelled"];
define field invoiced on saudi_visa_process type option<bool> default false;
define field item_unit on saudi_visa_process type record<item_unit>;
define field pipeline on saudi_visa_process type record<pipeline>;
define field created_at on saudi_visa_process type datetime default fn::utils::now();
define field completed_at on saudi_visa_process type option<datetime|null> default null;

remove field item_unit on saudi_visa_process;

define table saudi_job type normal schemaless permissions full;
define field english_name on saudi_job type string;
define field arabic_name on saudi_job type string;
define field code on saudi_job type string;


define table saudi_visas_document type normal schemaless permissions full;
define field document_number on saudi_visas_document type string;
define field sponsor_id on saudi_visas_document type string;
define field sponsor_name_english on saudi_visas_document type string;
define field sponsor_name_arabic on saudi_visas_document type string;
define field sponsor_address on saudi_visas_document type string default "";
define field focal_person on saudi_visas_document type record<focal_person>;
define field completed on saudi_visas_document type bool default false;
define field created_at on saudi_visas_document type datetime default fn::utils::now();

define index unique_document_number on saudi_visas_document fields document_number unique;


define table svd_job type normal schemaless permissions full;
define field svd on svd_job type record<saudi_visas_document>;
define field job on svd_job type object;
define field jobs_count on svd_job type int;
define field embassy on svd_job type string;


define table svp_assigned_job type normal schemaless permissions full;
define field svd on svp_assigned_job type record<saudi_visas_document>;
define field svd_job on svp_assigned_job type record<svd_job>;
define field status on svp_assigned_job type option<string> default "assigned" assert $value in ["assigned", "cancelled", "issued"];




define table candidate_profile type normal schemaless permissions full;
define field given_name on candidate_profile type string;
define field surname on candidate_profile type string;
define field father_given_name on candidate_profile type string;
define field father_surname on candidate_profile type string;
define field dob on candidate_profile type string;
define field place_of_birth on candidate_profile type string;
define field passport_issue_place on candidate_profile type string;
define field passport_number on candidate_profile type string;
define field passport_issue_date on candidate_profile type string;
define field passport_expiry_date on candidate_profile type string;
define field merital_status on candidate_profile type string;
define field religion on candidate_profile type string;
define field cnic on candidate_profile type string;
define field picture on candidate_profile type string;
define field gender on candidate_profile type string;
define field notes on candidate_profile type string;
define field created_at on candidate_profile type datetime default fn::utils::now();
define field status on candidate_profile type string default "active" assert $value in ["active", "inactive"];

define index unique_pp on candidate_profile fields passport_number unique;


define table focal_person type normal schemaless permissions full;
define field name on focal_person type string;
define field reference on focal_person type string;
define field contacts on focal_person type string;
define field created_at on focal_person type datetime default fn::utils::now();



// PIPELINES

define table pipeline_template type normal schemaless permissions full;
define field name on pipeline_template type string;


define table pipeline_template_stage type normal schemaless permissions full;
define field template on pipeline_template_stage type record<pipeline_template>;
define field name on pipeline_template_stage type string;
define field description on pipeline_template_stage type string;
define field order on pipeline_template_stage type int;
//{name: string, description: string}
define field tasks on pipeline_template_stage type array<object>;


define table pipeline type normal schemaless permissions full;
define field template on pipeline type record<pipeline_template>;
define field finished on pipeline type bool default false;
define field current_stage on pipeline type option<record<stage>|null> default null;


define table stage type normal schemaless permissions full;
define field pipeline on stage type record<pipeline>;
define field template_stage on stage type record<pipeline_template_stage>;
define field completed on stage type option<bool> default false;



define table stage_task type normal schemaless permissions full;
define field stage on stage_task type record<stage>;
define field name on stage_task type string;
define field description on stage_task type string;
define field done on stage_task type bool default false;

// doc gen
define table template type normal schemaless permissions full;
define field name on template type string assert string::len($value) != 0;
define field file_id on template type string assert string::len($value) != 0;
define field vars on template type object;
define field created_at on template type datetime;

define index unique_template_name on template fields name unique;


define table resource_template_mapping type normal schemaless permissions full;
define field resource on resource_template_mapping type string;
define field template on resource_template_mapping type record<template>;
/*
mapping -> {
    template_variable: string,
    value_accessor: {
        name: string,
        accessor: string,   eg: "profile.name"
    }
}



*/
define field mapping on resource_template_mapping type object;

define index unique_template_resource on resource_template_mapping fields resource, template unique;


//          ============================FLOWS===========================

// accounting reporting
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
        order by transaction.date desc;

};


define function overwrite fn::reporting::customer_account_balance_till($customer_id: record<entity>, $dt: string){
    let $customer = select * from only $customer_id;
    let $account = $customer.customer_account;
    let $date = time::floor(<datetime>$dt, 1d);
    let $b = select *, math::sum(incr-decr) as balance from only sl_account_entry 
        where account=$account and time::floor(transaction.date, 1d) < $date
    group all
    order by transaction.date desc limit 1;

    return if($b==none){
        return 0;
    }else{
        return $b.balance;
    };
};


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
        order by transaction.date desc;

};


define function overwrite fn::reporting::vendor_account_balance_till($vendor_id: record<entity>, $dt: string){

    let $vendor = select * from only $vendor_id;
    let $account = $vendor.vendor_account;
    let $date = time::floor(<datetime>$dt, 1d);
    
    let $b = select *, math::sum(incr-decr) as balance from only sl_account_entry 
        where account=$account and time::floor(transaction.date, 1d) < $date
    group all
    order by transaction.date desc limit 1;

    return if($b==none){
        return 0;
    }else{
        return $b.balance;
    };
};

define function overwrite fn::reporting::receivable_statement(){
    return select *, account.balance as balance from entity where status=="active" and type="customer";
};


define function overwrite fn::reporting::payable_statement(){
    return select *, -1 * account.balance as balance from entity where status=="active" and type="vendor";
};


define function overwrite fn::reporting::balance_sheet(){

    // assets total
    let $assets_total = select value total from only (
    select math::sum(balance) as total from only gl_account where type="asset" group all
    );

    // assets -> bank balances
    let $bank_balances = select asset_account.balance as balance from bank_account;
    let $banks_total = array::fold($bank_balances, 0, |$prev, $a| $prev + $a.balance);

    // assets -> cash
    let $cash = select value balance from only gl_account where name="Cash" limit 1;

    // assets -> receivable
    let $recievable_balances = select account.balance as balance from entity where
        type="customer";
    let $receivable = array::fold($recievable_balances, 0, |$prev, $a| $prev + $a.balance);

    //LIABILITY

    // payable
    let $payable_balances = select -1*account.balance as balance from entity 
        where type="vendor";
    let $payable= array::fold($payable_balances, 0, |$prev, $a| $prev + $a.balance);
    
    return {
        assets: {
            total: $assets_total + $receivable,
            banks: $banks_total,
            cash: $cash,
            receivable: $receivable,
            
        },
        liabilities: {
            total: $payable,
            payable: $payable,
        },
    };
    
    
};


define function overwrite fn::reporting::income_statement($start: string, $end: string){

    let $start_date = time::floor(<datetime>$start, 1d);
    let $end_date = time::floor(<datetime>$end,1d);

    // operating revenue
    let $income_accounts = select income_account from item;
    $income_accounts = array::map($income_accounts, |$acc| $acc.income_account);
    
    $sum = select account, math::sum(incr-decr) as total
            from gl_account_entry 
                where account in $income_accounts and
                    time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
            group by account;
    
    $sum = array::map($sum, |$val| $val.total);
    
    let $op_rev = math::sum($sum);


    let $cogs_accounts = select cogs_account from item;
    $cogs_accounts = array::map($cogs_accounts, |$acc| $acc.cogs_account);
    
    $sum = select account, math::sum(incr-decr) as total
                  from gl_account_entry 
                    where account in $cogs_accounts and
                     time::floor(transaction.date, 1d) >= $start_date and
                    time::floor(transaction.date, 1d) <= $end_date
                    group by account;
    
    $sum = array::map($sum, |$val| $val.total);
    
    let $op_exp = math::sum($sum);

    return {
        "revenue": $op_rev,
        "cogs": $op_exp,
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
        select account, math::sum(incr - decr) as total from only gl_account_entry where account =  $parent.cogs_account  and
    time::floor(transaction.date, 1d) >= $start_date and
    time::floor(transaction.date, 1d) <= $end_date
        group by account
        
    ) as cogs

from item;

    return array::map($data, |$v| {
        {name: $v.name, revenue: $v.revenue.total??0, cogs: $v.cogs.total??0}
    });
};




// accounting
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

    if($purchase_details){
        fn::accounting::purchase_item(
            $purchase_details.item_id,
            $purchase_details,
            type::string($date),
        );
    };
    
};

define function overwrite fn::accounting::purchase_item(
    $item_id: record<item>,
    $details: object,
    $date: string,
){

    let $item = select * from only $item_id;
    if(!$item){
        throw "invalid request";
    };

    if($item.is_service = true){
        throw "can not purchase service item";
    };

    let $pmt = $details.payment_method;

    let $tx = create only transaction content {
        type: "purchase",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };

    create only gl_account_entry content{
        account: $item.cogs_account,
        description: $details.description,
        reference: $details.reference,
        incr: <int>$details.amount,
        decr: 0,
        transaction: $tx.id,
    };

    let $account = 
    if($pmt["method"]=="bank"){
        return $pmt["account"];
    }
    else if ($pmt["method"] == "cash"){
        return select value id from only gl_account where type="asset" and name="Cash" limit 1;
    }else if($pmt.entity){
        return $pmt.entity;
    }
    else{
        throw "invalid payment method";
    };

    $pmt = $details.payment_method;

    let $res = if($pmt.entity){
    let $entity = select * from only $pmt.entity;
    return create only sl_account_entry content{
        account: $entity.account,
        description: $details.description,
        reference: $details.reference,
        decr: <int>$details.amount,
        incr: 0,
        transaction: $tx.id,
    };
        
    }else{
    return create only gl_account_entry content{
        account: $account,
        description: $details.description,
        reference: $details.reference,
        decr: <int>$details.amount,
        incr: 0,
        transaction: $tx.id,
        };
    };
    
    return select * from only $res;
};


define function overwrite fn::accounting::add_payment(
    $entity: record<entity>,
    $method: object,
    $type: string,   // sent, received
    $amount: int,
    $reference: string,
    $description: string,
    $date: string,
){

    if($amount <= 0){
        throw "Amount must be greater then 0";
    };


    let $tx_type = if($type=="sent"){
        return "payment_made"
    }else if($type == "received"){
        return "payment_received";
    }else{
        throw "invalid payment type";
    };


    let $tx = create only transaction content{
        type: $tx_type,
        date: <datetime>$date,
        created_at: fn::utils::now(),
      };

    let $var_entity = select * from only $entity;

    let $asset_account = 
    if($method["method"]=="bank"){
        return $method["account"];
    }
    else if ($method["method"] == "cash"){
        return select value id from only gl_account where type="asset" and name="Cash" limit 1;
    }else{
        throw "invalid payment method";
    };
    
    # gl

    create only gl_account_entry content {
        account: $asset_account,
        incr: if($type == "received"){$amount}else{0},
        decr: if($type == "received"){0}else{$amount},
        description: $description,
        reference: $reference,
        transaction: $tx.id,        
    };

    select * from gl_account_entry where account.name="Cash";


    # sub ledger
    let $account = $entity.account;


    let $gl_entry = create only sl_account_entry content{
        account: $account,
        incr: if($type == "received"){0}else{$amount},
        decr: if($type == "received"){$amount}else{0},
        description: $description,
        reference: $reference,
        transaction: $tx.id,
    };

    select * from sl_account_entry;
    


    return select * from only $gl_entry;
    
};


define function overwrite fn::accounting::delete_transaction($tx: record<transaction>){

    delete gl_account_entry where transaction=$tx;
    delete sl_account_entry where transaction=$tx;

    delete $tx;

    return true;
};

// banking
define function overwrite fn::add_bank($name: string, $abbr: string){
    return create only bank content {
        name: $name,
        abbr: $abbr,
    };
    
};


define function overwrite fn::add_bank_account(
    $bank: record<bank>,
    $title: string,
    $account_no: string,
    $iban: option<string|null>,
){
     let $var_bank = select * from only $bank;
      let $asset_acc = create only gl_account content {
        name: "bank:" + $bank.name + ":" + $title,
        type: "asset",
      };

      let $banks_account = select * from only gl_account where name="Banks" and type="asset" limit 1;

      relate $asset_acc -> gl_subaccount_of -> $banks_account;

      return create only bank_account content {
        bank: $var_bank.id,
        title: $title,
        asset_account: $asset_acc.id,
        account_no: $account_no,
        iban: $iban,
      };
};

define function overwrite fn::add_bank_account_deposit(
    $bank_account: record<bank_account>,
    $amount: int,
    $ref: string,
    $desc: string,
    $date: string
){

    let $tx = create only transaction content{
        type: "bank_deposit",
        created_at: fn::utils::now(),
        date: <datetime>$date,
      };

    let $var_bank_account = select * from only $bank_account;
    
    let $gl_bank_account = $var_bank_account.asset_account;
    let $gl_cash_account = select * from only gl_account where type="asset" and name="Cash" limit 1;


    -- let $bca = create only bank_account_deposit content {
    --     account: $bank_account,
    --     amount: $amount,
    --     reference: $ref,
    --     description: $desc,
    --     transaction: $tx.id,
    -- };


    create only gl_account_entry content {
        account: $gl_cash_account.id,
        incr: 0,
        decr: $amount,
        description: $desc,
        ref: $ref,
        transaction: $tx.id,
    }; 


    return create only gl_account_entry content {
        account: $gl_bank_account.id,
        incr: $amount,
        decr: 0,
        description: $desc,
        ref: $ref,
        transaction: $tx.id,
    }; 

};




define function overwrite fn::add_bank_account_withdrawal(
    $bank_account: record<bank_account>,
    $amount: int,
    $ref: string,
    $desc: string,
    $date: string
){

    let $tx = create only transaction content{
        type: "bank_withdrawal",
        created_at: fn::utils::now(),
        date: <datetime>$date,
      };

    let $var_bank_account = select * from only $bank_account;
    let $gl_bank_account = $var_bank_account.asset_account;
    let $gl_cash_account = select * from only gl_account where type="asset" and name="Cash" limit 1;


    -- let $bca = create only bank_account_withdrawl content {
    --     account: $bank_account,
    --     amount: $amount,
    --     reference: $ref,
    --     description: $desc,
    --     transaction: $tx.id,
    -- };

    create only gl_account_entry content {
        account: $gl_cash_account.id,
        incr: $amount,
        decr: 0,
        description: $desc,
        ref: $ref,
        transaction: $tx.id,
    }; 


    return create only gl_account_entry content {
        account: $gl_bank_account.id,
        incr: 0,
        decr: $amount,
        description: $desc,
        ref: $ref,
        transaction: $tx.id,
    }; 


};


// dashboard

// IMPROVE
define function overwrite fn::daily_revenue($date: string){
    let $dt = <datetime>$date;
    return select account.name as account_name, math::sum(incr-decr) as amount
    from gl_account_entry 
        where account.type="income" and 
              time::year(transaction.date) == time::year($dt) and
              time::month(transaction.date) == time::month($dt) and
              time::day(transaction.date) == time::day($dt)
                   group by account_name;

};

define function overwrite fn::monthly_revenue($m: string){
    let $dt = <datetime>$m;
    return select account.name as account_name, math::sum(incr-decr) as amount
    from gl_account_entry 
        where account.type=="income" and 
              time::month(transaction.date) == time::month($dt) and 
              time::year(transaction.date) == time::year($dt)
                   group by account_name;
};

define function overwrite fn::yearly_revenue($y: int){
    return select account.name as account_name, math::sum(incr-decr) as amount
    from gl_account_entry 
        where account.type="income" and 
              time::year(transaction.date) == $y
                   group by account_name;
};

define function overwrite fn::months_revenue_by_year($y: int){
    return select time::month(transaction.date) as month, math::sum(incr-decr) as amount from gl_account_entry
        where account.type == "income" and
                time::year(transaction.date) == $y
                group by month;
};

define function overwrite fn::daily_payments($d: string){
    let $dt = time::floor(<datetime>$d, 1d);
    let $recv =  select transaction.date as date, math::sum(decr) as total
    from sl_account_entry where transaction.type=="payment_received" and
        time::floor(transaction.date, 1d) == $dt
        group by transaction.date;


    let $paid =  select transaction.date as date, math::sum(decr) as total
    from sl_account_entry where transaction.type=="payment_made" and
        time::floor(transaction.date, 1d) == $dt
        group by transaction.date;

    let $recv = select * from only $recv limit 1;
    let $paid = select * from only $paid limit 1;
    return {
        received: $recv.total??0,
        paid: $paid.total??0,
    };
};


define function overwrite fn::monthly_payments($m: string){
    let $dt = <datetime>$m;
    let $dt = time::now();
    let $recv =  select time::month(transaction.date) as month,
    math::sum(incr) as total 
        from sl_account_entry where transaction.type=="payment_made" and
        time::year(transaction.date) == time::year($dt) and
        time::month(transaction.date) == time::month($dt)
        group by month;

    let $paid =  select time::month(transaction.date) as month,
    math::sum(incr) as total 
        from sl_account_entry where transaction.type == "payment_received" and
        time::year(transaction.date) == time::year($dt) and
        time::month(transaction.date) == time::month($dt)
        group by month;

    let $recv = select * from only $recv limit 1;
    let $paid = select * from only $paid limit 1;
    return {
        received: $recv.total??0,
        paid: $paid.total??0,
    };
};
define function overwrite fn::yearly_payments($y: int){

    let $recv = select time::year(transaction.date) as year, math::sum(incr) as total
    from sl_account_entry where transaction.type=="payment_made" and
        time::year(transaction.date) == $y group by year;

    let $paid = select time::year(transaction.date) as year, math::sum(incr) as total
    from sl_account_entry where transaction.type=="payment_received" and
        time::year(transaction.date) == $y group by year;

    let $recv = select * from only $recv limit 1;
    let $paid = select * from only $paid limit 1;
    return {
        received: $recv.total,
        paid: $paid.total?,
    };
};

define function overwrite fn::months_payments_by_year($y: int){
    return select time::month(transaction.date) as month, math::sum(amount) as total from 
        payment_receipt where
            time::year(transaction.date) == $y
                group by month;
};



define function overwrite fn::active_vp_by_template($pt: record<pipeline_template>){
   return select count() as count, stages[where status="active"].name[0] as stage 
    from pipeline 
    where template=$pt
    group by stage;
};




define function overwrite fn::get_cash_on_hand(){

    let $acc = select * from only gl_account where name="Cash" and type="asset" limit 1;

    return $acc.balance;
};



define function overwrite fn::get_cash_in_banks(){
    let $balances = select  asset_account.balance as balance from bank_account;
    let $result = array::reduce($balances, |$a, $b| $a.balance + $b.balance);
    return $result.balance ?? 0;
};


// docgen

define function overwrite fn::templates::add($name: string, $file_id: string, $vars: object){
    return create only template content{
    name: $name,
    file_id: $file_id,
    vars: $vars,
    created_at: fn::utils::now(),
    };
};


define function overwrite fn::templates::delete($id: record<template>){
    let $temp = select * from only $id;

    if(!$temp){
        throw "invalid request";
    };
    
    delete $id;

    return true;
};


define function overwrite fn::create_mapping(
    $template: record<template>, 
    $resource: string,
    $mappings: object,
){
    let $mp = create only resource_template_mapping content {
        template: $template,
        resource: $resource,
        mapping: $mappings,
    };

    return select * from only $mp;
};

define function overwrite fn::delete_mapping($id: record<resource_template_mapping>){
    delete $id;
    return true;
};

//entity
define function overwrite fn::add_entity(
    $name: string,
    $balance: option<int|null>,
    $address: option<string|null>,
    $contacts: option<array<string>|null>,
    $picture: option<string|null>,
    $balance_as_of: option<string|null>,
    $type: string,
    
){

    let $account = create only sl_account;
    
    let $var_customer = create only entity content {
        name: $name,
        address: $address,
        contacts: $contacts,
        picture: $picture,
        account: $account.id,
        type: $type,
    };

    if $balance{
        let $tx = create only transaction content{
            type: "opening_balance",
            created_at: fn::utils::now(),
            date: <datetime>$balance_as_of,
        };
        
        if $balance < 0 {
          create only sl_account_entry content {
              account: $account.id,
              incr: 0,
              decr: $balance,
              description: "opening balance",
              reference: "",
              transaction: $tx.id,
          };     
        }else {
        create only sl_account_entry content {
                account: $account.id,
                incr: $balance,
                decr: 0,
                description: "opening balance",
                reference: "",
                transaction: $tx.id,
          }; 
        
        };
        

    };
    
    return select * from only $var_customer;
};
    
define function overwrite fn::update_entity(
    $entity: record<entity>,
    $name: string,
    $address: string,
    $contacts: array<string>,
    $status: string,
    $picture: option<string|null>,
    $entity_type: option<object|null>,
){

    if($entity_type.to_vendor == true and $entity_type.to_customer == true){
      throw "invalid request";  
    };
    
    let $var_entity = select * from only $entity;
    if($status!=$var_entity.status){
      if($status=="active"){
          fn::activate_entity($entity);
      };  
        if($status=="inactive"){
            fn::inactivate_entity($entity);
        };
    };

    return update only $entity merge {
        name:$name,
        contacts:$contacts,
        address: $address,
        picture: $picture
    };
};



define function overwrite fn::inactivate_entity($entity: record<entity>){
    let $var_entity = select * from only $entity;
    let $customer_acc = select * from only $var_entity.account;

    if(!$customer_acc){
        throw "invalid entity";
    };

    if ($customer_acc and $customer_acc.balance != 0){
      throw "can not inactivate entity with balance";  
    };

    return update only $entity set status="inactive";
};

    
define function overwrite fn::activate_entity($e: record<entity>){

    return update only $e set status="active";
};


// equity
define function overwrite fn::add_drawing(
    $amount: int,
    $method: object,
    $date: string,
    $description: string,
){

     let $asset_account = 
    if($method["method"]=="bank"){
        return $method["account"]
    }else if($method["method"]=="cash"){
        return select value id from only gl_account where type="asset" and name="Cash" limit 1;  
    }else{
        throw "invalid payment method";
    };
    
    
    let $tx = create only transaction content {
        type: "equity_drawing",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };


    create only gl_account_entry content{
        account: $asset_account,
        incr:0,
        decr: $amount,
        description: $description,
        reference: "",
        transaction: $tx.id,
    };


    let $drawing = select * from only gl_account where type="equity" and name="OwnerDraw" limit 1;
    let $res = create only gl_account_entry content{
        account: $drawing.id,
        incr:$amount,
        decr: 0,
        description: $description,
        reference: "",
        transaction: $tx.id,
    };

    return select *, transaction.* as tx from only $res;
};


    define function overwrite fn::add_capital(
    $amount: int,
    $method: object,
    $date: string,
    $description: string,
){

     let $asset_account = 
        if($method["method"]=="bank"){
            return $method["account"]
        }else if($method["method"]=="cash"){
            return select value id from only gl_account where type="asset" and name="Cash" limit 1;  
        }else{
            throw "invalid payment method";
        };
    
    let $tx = create only transaction content {
        type: "equity_add_capital",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };


    create only gl_account_entry content{
        account: $asset_account,
        incr:$amount,
        decr: 0,
        description: $description,
        reference: "",
        transaction: $tx.id,
    };

    let $capital = select * from only gl_account where type="equity" and name="OwnerCapital" limit 1;
    let $res = create only gl_account_entry content{
        account: $capital.id,
        incr:$amount,
        decr: 0,
        description: $description,
        reference: "",
        transaction: $tx.id,
    };

    return select *, transaction.* as tx from only $res;
};

// expenses



define function overwrite fn::add_expense_account(
    $name: string,

){

    return create only gl_account content {
        name: $name,
        type: "expense",
        meta: {
            "type": "custom"
        },
    };

};




define function overwrite fn::add_expense(
    $account: record<gl_account>,
    $amount: int,
    $method: object,
    $description: string,
    $ref: string,
    $date: string,
){

    let $tx = create only transaction content {
        type: "expense",
        created_at: fn::utils::now(),
        date: <datetime>$date,
    };

    let $asset_account = 
    if($method["method"]=="bank"){
        return $method["account"]
        
    }else if($method["method"]=="cash"){
            return select value id from only gl_account where type="asset" and name="Cash" limit 1;
    }else{
        throw "invalid payment method";
    };
    

    create gl_account_entry content{
        account: $asset_account,
        incr: 0,
        decr: $amount,
        description: $description,
        reference: $ref,
        transaction: $tx.id
    };


    let $res = create only gl_account_entry content {
        account: $account,
        incr: $amount,
        decr: 0,
        description: $description,
        referene: $ref, 
        transaction: $tx.id,
    };

    return select *, transaction.* as tx from only $res;
    
};

// files

define function overwrite fn::add_folder($name: string, $ffor: record){
    let $folder = create only folder content {name: $name};
    let $folder_id = $folder.id;
    relate $folder_id -> folder_belongs_to -> $ffor;

    return $folder;
};


define function overwrite fn::get_folders($ref: record){
    return 
    select value folders from only (
select  <- folder_belongs_to <- folder as folders from only $ref
    );
};



define function overwrite fn::add_folder_file($identifier: string, $meta: object, $folder: record<folder>){
      let $file = create only file content {
          identifier: $identifier,
          metadata: $meta,
          folder: $folder,
          name: $meta.name,
      }; 

    let $file_id = $file.id;

    -- relate $folder -> folder_contains -> $file_id;

    return $file;
};


define function overwrite fn::get_folder_files($folder: record<folder>){
    return select * from file where folder=$folder;

};

define function overwrite fn::files::rename_file($file: record<file>, $name: string){
    if(string::len($name) == 0){
        throw "name is required";
    };

    if(string::matches('[<>:"/\\|?*]', $name)){
        throw "invalid name, name should not contain special characters.";
    };
    return update only $file set name=$name;
};


// items


define function overwrite fn::add_item(
        $name: string,
        $purchase_description: string,
        $sale_description: string,
        $is_service: bool,
    ){

    
    let $asset_account = create only gl_account content {
        name: rand::ulid(),
        type: "asset",
        };

    let $income_account = create only gl_account content {
    name: rand::ulid(),
    type: "income",
    };

    

    let $contra_income_account = create only gl_account content {
    name: rand::ulid(),
    type: "contra_income",
    };

    let $expense_account = create only gl_account content {
    name: rand::ulid(),
    type: "expense",
    };

    let $contra_expense_account = create only gl_account content {
    name: rand::ulid(),
    type: "contra_expense",
    };


    return create only item content {
        name: $name,
        purchase_description: $purchase_description,
        sale_description: $sale_description,
        is_service: $purchased,
        asset_account: $asset_account.id,
        income_account: $income_account.id,
        contra_income_account: $contra_income_account.id,
        cogs_account: $expense_account.id,
        contra_cogs_account: $contra_expense_account.id,
    };
};

define function overwrite fn::edit_item($item: record<item>, $sales_desc: string, $purc_desc: string){
    update $item merge {
        sale_description: $sales_desc,
        purchase_description: $purc_desc,
    };

    return select * from only $item;
};


define function overwrite fn::delete_item($item_id: record<item>){
    let $item = select *, asset_account.*, income_account.*, contra_income_account.*,
                           cogs_account.*, contra_cogs_account.*
                from only $item_id;


    if($item.asset_account.balance != 0 or $item.income_account.balance != 0 or
        $item.contra_income_account.balance != 0 or $item.cogs_account.balance != 0 or
        $item.contra_cogs_account.balance !=0
    ){
        throw "item with transactions can not be deleted";
    };

    delete $item_id;
    return true;
};

define function overwrite fn::get_all_items(){
    return select * from item;
};



// pipelines
define function overwrite fn::add_pipeline_template(
    $name: string, 
    $stages: array<object>,
){
    let $template = create only pipeline_template content{
        name: $name,
    };

    for $obj in $stages {
        create pipeline_template_stage content {
            template: $template.id,
            name: $obj.name,
            description: $obj.description,
            order: $obj.index,
            tasks: $obj.tasks,
        }
    };

    return fn::pipelines::get_template_full($template.id);
};


define function overwrite fn::pipelines::get_template_full($id: record<pipeline_template>){
    let $count = select id from pipeline where template=$id group all;
    return select *,
                  array::len($count) as active_pipelines,
                  (select * from pipeline_template_stage where template=$id order by order asc) as stages

            from only $id;
};




define function overwrite fn::pipelines::get_all_templates_full(){
    return select *,
                  array::len(
                    select id from pipeline where template=$parent.id
                  ) as active_pipelines,
                  (select * from pipeline_template_stage where template=$parent.id order by order asc) as stages

            from pipeline_template;
};


define function overwrite fn::pipelines::update_template(
    $template_id: record<pipeline_template>,
    $name: string|null,
){

    let $template = select * from only $template_id;
    if(!$template){
        throw "invalid template";
    };

    update only $template_id merge {
        name: $name??$template.name,
    };

    return fn::pipelines::get_template_full($template_id);
    
};


define function overwrite fn::pipelines::update_template_stage(
    $stage_id: record<pipeline_template_stage>,
    $name: string|null,
    $description: string|null
){

    let $template_stage = select * from only $stage_id;
    if(!$template_stage){
        throw "invalid stage";
    };

    update only $stage_id merge {
        name: $name??$template_stage.name,
        description: $description??$template_stage.description,
    };

    return fn::pipelines::get_template_full($template_stage.template);
    
};


define function overwrite fn::pipelines::update_template_stage_tasks(
    $stage_id: record<pipeline_template_stage>,
    $tasks: array<object>,
){

    let $template_stage = select * from only $stage_id;
    if(!$template_stage){
        throw "invalid stage";
    };

    update only $stage_id merge {
        tasks: $tasks
    };


    return fn::pipelines::get_template_full($template_stage.template);
    
};



define function overwrite fn::pipelines::create_pipeline($template_id: record<pipeline_template>){

    let $template = fn::pipelines::get_template_full($template_id);

    if !$template{
          throw "invalid pipeline template";  
    };


    let $pipeline = create only pipeline content {
        template: $template_id,
    };


    for $stg in $template.stages {
        let $stage = create only stage content {
            pipeline: $pipeline.id,
            template_stage: $stg.id,
        };

        for $tsk in $stg.tasks {
            create only stage_task content {
                stage: $stage.id,
                name: $tsk.name,
                description: $tsk.description,
            };
        };
    };

    update only $pipeline merge {
        current_stage: (select * from only stage where pipeline=$pipeline.id and template_stage.order=0 limit 1).id
    };


    return fn::pipelines::get_pipeline_full($pipeline.id);
    
};


define function overwrite fn::pipelines::get_pipeline_full($id: record<pipeline>){
    return select *,
            template.name as template_name,
            (
                select *,
                template_stage.*,
                (select * from stage_task where stage=$parent.id) as tasks
                from stage where pipeline=$id order by template_stage.order
        
            ) as stages,
            if current_stage {fn::pipelines::get_pipeline_stage_full(current_stage)} as current_stage

            from only $id;
};


define function overwrite fn::pipelines::get_pipeline_stage_full($id: record<stage>){
    return select *,
            template_stage.*,
            (select * from stage_task where stage=$id) as tasks
            from only $id;
};



define function overwrite fn::pipelines::change_task_status(
    $id: record<stage_task>,
    $status: bool
){
    let $task = select * from only $id;
    if !$id{
        throw "invalid task";
    };

    update only $id merge {
        done: $status
    };

    return true;
};



define function overwrite fn::pipelines::complete_stage($id: record<stage>){
    let $stage = select *, template_stage.order as order from only $id;
    
    if !$stage{
        throw "invalid stage";
    };

    let $arr = select *, template_stage.order as ord
        from stage where pipeline = $stage.pipeline order by ord asc;

    let $total_stages = array::len($arr);

   

    // check if last
    if ($stage.order == $total_stages-1){
        update only $stage.pipeline merge{
            finished: true,
            current_stage: null
            
        };
    }else if($stage.order < $total_stages-1){
        // get next stage
        let $next = select * from only $arr where ord=($stage.order + 1) limit 1;
        update only $stage.pipeline set
            current_stage = $next.id;
    };

     update only $id merge {
        completed: true
    };

    

    return true;
};



define function overwrite fn::pipelines::template_report($template_id: record<pipeline_template>){
    return select count() as cases,  current_stage.template_stage as stage
    from pipeline where template=$template_id
    group by stage
    ;
};


// svp reports
define function overwrite fn::svp_reports::get_document_report($svd_id: record<saudi_visas_document>){
    let $svd = fn::get_full_svd($svd_id);

    if !$svd{
        throw "invalid document";
    };

    let $svps = fn::svps::get_all_svps_full_by_document($svd_id);

    return {
        "svd": $svd,
        "svps": $svps
    };
};


define function overwrite fn::svp_reports::focal_person_active_documents_report(
    $fp_id: record<focal_person>
){
    let $docs = select value id from saudi_visas_document 
        where focal_person.id=$fp_id;

    return select value fn::svp_reports::get_document_report(id) from $docs
};

// tasks

define function overwrite fn::tasks::add_category(
    $name: string,
    $desc: string,
){
    return create only task_category content {
        name: $name,
        description: $desc,
    };
};



define function overwrite fn::tasks::add_task(
    $name: string,
    $desc: string,
    $category_id: record<task_category>,
    $deadline: string,
    $last_critical_days: int,
    $meta: object,
){
    return create only task content {
        name: $name,
        description: $desc,
        category: $category_id,
        deadline: <datetime>$deadline,
        last_critical_days: $last_critical_days,
        meta: $meta,
    };
};

define function overwrite fn::tasks::complete_task($task_id: record<task>){
    delete $task_id;
    return true;
};

define function overwrite fn::tasks::get_categories(){
    return select * from task_category;
};

define function overwrite fn::tasks::get_tasks(){
    return select * from task order by deadline asc;
};

// ticketing
define function overwrite fn::add_ticket(
    $pnr: string,
    $passengers: array<object>,
    $sectors: array<object>,
    ){

    return create only ticket content {
        pnr: $pnr,
        passengers: $passengers,
        sectors: $sectors,
        created_at:fn::utils::now(),
        refunded: false,
    };
};

define function overwrite fn::tickets::get_all_pending(){
    let $today = time::floor(fn::utils::now(), 1d);
    return SELECT *
    FROM ticket
    WHERE array::any(
    sectors, 
    |$sector| time::floor(<datetime>$sector.departure_date, 1d) >= time::floor(fn::utils::now(), 1d)
    );

};

define function overwrite fn::tickets::get_tickets_stats_by_month($month: int, $year: int){
    return SELECT *, time::floor(created_at, 1d) as date,
    count()
    FROM ticket 
    where time::month(created_at) = $month and time::year(created_at) = $year
    group by date
    ;
};

define function overwrite fn::tickets::get_tickets_stats_by_year($year: int){
    return SELECT *, time::month(created_at) as month, count()
    FROM ticket 
    where time::year(created_at) = $year
    group by month;
};

define function overwrite fn::tickets::edit_ticket(
    $id: record<ticket>, 
    $pnr: string, 
    $passengers: array<object>, 
    $sectors: array<object>,
    $refund: bool,
){
    let $tick = select * from only $id;
    if !$tick{
        throw "invalid request";
    };

    return update only $id content {
        pnr: $pnr,
        passengers: $passengers,
        sectors: $sectors,
        refunded: $refund,
    };
    
};


define function overwrite fn::tickets::delete_ticket($id: record<ticket>){
    let $tick = select * from only $id;
    if !$tick {
        throw "invalid request";
    };

    delete $tick;

    return true;
};


// utils
define function overwrite fn::get_subaccounts($acc: record<gl_account>){
   let $res = select <- gl_subaccount_of <- gl_account as subs from only $acc.id;
    return select *, $acc as parent from  $res["subs"];
};


define function overwrite fn::utils::get_gl_account_balance_btw(
    $account: record<gl_account>, 
    $start: string, 
    $end: string
){
    let $start_date = time::floor(<datetime>$start, 1d);
    let $end_date = time::floor(<datetime>$end, 1d);

    let $entries = select * from gl_account_entry 
        where account=$account and
            time::floor(transaction.date, 1d) >= $star_date and
            time::floor(transaction.date, 1d) <= $end_date
        order by transaction.date asc;

    let $amounts = array::map($entries, |$ent| $ent.incr-$ent.decr);

    let $total = math::sum($amounts);

    return $total;
};


define function overwrite fn::utils::now(){
    return time::now() + 5h;
};

// visa process

define function overwrite fn::next_svp_no(){
    return (select * from count(select * from saudi_visa_process))[0] + 1;
};
 


// add document
define function overwrite fn::add_sv_document(
    $document_no: string,
    $sponsor_id: string,
    $sponsor_name: string,
    $sponsor_name_arabic: string,
    $sponsor_address: string,
    $focal_person: record<focal_person>,
    $jobs: array<object>,    // {job_id, job_count, embassy}
){


    let $doc = create only saudi_visas_document content {
        document_number: string::trim($document_no),
        sponsor_id: string::trim($sponsor_id),
        sponsor_name_english: string::trim($sponsor_name),
        sponsor_name_arabic: string::trim($sponsor_name_arabic),
        sponsor_address: string::trim($sponsor_address),
        focal_person: $focal_person,
    };

    for $obj in $jobs {
        create only svd_job content {
            svd: $doc.id,
            job: (select * from only $obj.job_id),
            jobs_count: $obj.jobs_count,
            embassy: $obj.embassy,
        };
        
    };

    return fn::get_full_svd($doc.id);
};

define function overwrite fn::edit_svd(
    $svd_id: record<saudi_visas_document>,
    $name_arabic: string,
    $name_english: string,
    $addr: string,
){
    let $svd = select * from only $svd_id;

    if(!$svd){
        throw "invalid request";
    };

    let $svd_updated = update only $svd_id merge {
        sponsor_name_arabic: $name_arabic,
        sponsor_name_english: $name_english,
        sponsor_address: $addr,
    };

    return fn::get_full_svd($svd_updated.id);
};



define function overwrite fn::complete_svd(
    $svd_id: record<saudi_visas_document>,
){
    let $svd = select * from only $svd_id;

    if(!$svd){
        throw "invalid request";
    };

    let $svd_jobs = select * from svd_job where svd=$svd_id;

    let $svd_jobs_count = math::sum(array::map($svd_jobs, |$a| $a.jobs_count));

    let $svp_cases = select * from saudi_visa_process where svd=$svd_id and status="completed";

    if(array::len($svp_cases) < $svd_jobs_count){
        throw "There are still pending cases/unassigned jobs";
    };

    let $svd_updated = update only $svd_id merge {
        completed: true
    };

    return fn::get_full_svd($svd_updated.id);
};


define function overwrite fn::uncomplete_svd(
    $svd_id: record<saudi_visas_document>,
){
    let $svd = select * from only $svd_id;

    if(!$svd){
        throw "invalid request";
    };


    let $svd_updated = update only $svd_id merge {
        completed: false
    };

    return fn::get_full_svd($svd_updated.id);
};


define function overwrite fn::delete_svd($svdId: record<saudi_visas_document>){
    let $svd = select * from only $svdId;
    if(!$svd){
        throw "Invalid requrest";
    };
    
    let $svps = select * from saudi_visa_process where svd=$svdId;
    if(array::len($svps)>0){
        throw "There are cases belonging to this document";
    };

    delete svp_assigned_job where svd=$svdId;
    delete $svdId;

    return true;
};



    

// profile

define function overwrite fn::add_candidate_profile(
    $givenName: string,
    $surname: string,
    $fatherGivenName: string,
    $fatherSurname: string,
    $placeOfBirth: string,
    $dateOfBirth: string,
    $passportNumber: string,
    $passportIssuePlace: string,
    $passportIssueDate: string,
    $passportExpiryDate: string,
    $meritalStatus: string,
    $religion: string,
    $gender: string,
    $cnic: string,
    $image: string,
    $notes: string,
){
     let $prof = create only candidate_profile content {
         given_name: string::trim($givenName),
         surname: string::trim($surname),
         father_given_name: string::trim($fatherGivenName),
         father_surname: string::trim($fatherSurname),
         place_of_birth: string::trim($placeOfBirth),
         dob: <datetime>$dateOfBirth,
         passport_number: string::trim($passportNumber),
         passport_issue_place: string::trim($passportIssuePlace),
         passport_issue_date: <datetime>$passportIssueDate,
         passport_expiry_date: <datetime>$passportExpiryDate,
         merital_status: string::trim($meritalStatus),
         religion: string::trim($religion),
         gender: $gender,
         cnic: string::trim($cnic),
         picture: $image,
         notes: $notes,
     };

    return select * from only $prof;
};



define function overwrite fn::edit_candidate_profile(
    $id: record<candidate_profile>,
    $givenName: string,
    $surname: string,
    $fatherGivenName: string,
    $fatherSurname: string,
    $placeOfBirth: string,
    $dateOfBirth: string,
    $passportNumber: string,
    $passportIssuePlace: string,
    $passportIssueDate: string,
    $passportExpiryDate: string,
    $meritalStatus: string,
    $religion: string,
    $gender: string,
    $cnic: string,
    $image: string,
    $notes: string,
){

    let $old = select * from only $id;
    if(!$old){
        throw "invalid request";
    };
    
     let $prof = update only $id merge {
         given_name: $givenName,
         surname: $surname,
         father_given_name: $fatherGivenName,
         father_surname: $fatherSurname,
         place_of_birth: $placeOfBirth,
         dob: <datetime>$dateOfBirth,
         passport_number: $passportNumber,
         passport_issue_place: $passportIssuePlace,
         passport_issue_date: <datetime>$passportIssueDate,
         passport_expiry_date: <datetime>$passportExpiryDate,
         merital_status: $meritalStatus,
         religion: $religion,
         gender: $gender,
         cnic: $cnic,
         picture: $image,
         notes: $notes,
     };

    return select * from only $prof;
};




define function overwrite fn::svps::change_profile_status(
    $prof: record<candidate_profile>,
    $status: string){
    return update only $prof set status=$status;
};




define function overwrite fn::svps::delete_profile($prof: record<candidate_profile>){
    let $svp = select * from saudi_visa_process where profile=$prof;

    if(array::len($svp) != 0){
        throw "can not delete profile, profile has assigned a case";
    };

    delete $prof;

    return true;
};



// cases
define function overwrite fn::add_svp(
    $profile_id: record<candidate_profile>,
    $svd: record<saudi_visas_document>,
    $svd_job_id: record<svd_job>,
    $pipeline_template_id: record<pipeline_template>,
){

    // steps:
    // 1: check if job is available if not throw an error
    // 2: ensure each profile has one case
    // 2: creaet svd_job
    // 3: handle accounting stuffs
    // 4: create svp

    // 1
    let $svd_job = select * from only $svd_job_id;
    let $svp_assigned_jobs = select * from svp_assigned_job where svd=$svd and svd_job=$svd_job.id
    and status != "cancelled";

    if($svp_assigned_jobs ==null  or array::len($svp_assigned_jobs) == $svd_job.jobs_count){
        throw "no available jobs";
    };

    let $case = select * from saudi_visa_process where profile=$profile_id and status == "active";

    if $case {
        throw "There is already an active case for this profile";
    };


    let $svp_assign_job = create only svp_assigned_job content {
        svd: $svd,
        svd_job: $svd_job.id, 
    };

    let $profile = select * from only $profile_id;

    let $item = select * from only item where name == "svp" limit 1;   
    
    -- let $unit = fn::svps::add_svp_item_unit(
    --     $item.id, 
    --     "visa process for " + $profile.passport_number,
    --     "visa process for " + $profile.passport_number,
    --     type::string(time::now()),
    --     [],
    -- );


    let $pipeline = fn::pipelines::create_pipeline($pipeline_template_id);

    if(!$pipeline){
        throw "error while creating pipeline";
    };


    let $process = create only saudi_visa_process content {
        svd: $svd,
        assigned_job: $svp_assign_job.id,
        profile: $profile.id,
        item_unit: $unit.id,
        pipeline: $pipeline.id
    };


    return select * from only $process;

};




define function overwrite fn::svps::complete_svp($svp_id: record<saudi_visa_process>){
    let $svp = select * from only $svp_id;

    if !$svp{
        throw "visa process does not exists";
    };

    let $pipeline = select * from only $svp.pipeline;

    if($pipeline.finished == false){
        throw "pipeline must be finished";
    };

    update only $svp_id set status = "completed", created_at=time::now();

    return fn::get_full_svp($svp_id);
};


define function overwrite fn::svps::delete_svp($svp_id: record<saudi_visa_process>){
    let $svp = select * from only $svp_id;

    if !$svp{
        throw "visa process does not exists";
    };

    -- let $unit = select * from only $svp.item_unit;
    -- let $uparts = select * from item_unit_part where unit = $svp.item_unit;

        

    -- if(array::len($uparts) == 0){
    --     delete $svp.item_unit;
    -- }else if($unit.invoiced == false){
    --     throw "can not delete process with balance";
    -- };

    delete $svp.assigned_job;

    if($svp.pipeline){
    delete $svp.pipeline;
        
    };

    delete $svp_id;

    return true;
};



define function overwrite fn::svps::cancel_svp($svp_id: record<saudi_visa_process>){
    let $svp = select * from only $svp_id;

    if !$svp{
        throw "visa process does not exists";
    };

    -- delete $svp.assigned_job;

    update only $svp.assigned_job set status="cancelled"; 

    update only $svp_id set status="cancelled";

    return fn::get_full_svp($svp_id);
};




define function overwrite fn::add_focal_person($name: string, $ref: string, $contacts: string){
    let $fp = create only focal_person content {
        name: $name,
        reference: $ref,
        contacts: $contacts,
    };

    return select * from only $fp;
};

define function overwrite fn::edit_focal_person($id: record<focal_person>, $name: string, $ref: string, $contacts: string){
    
    let $fp = update only $id merge {
        name: $name,
        reference: $ref,
        contacts: $contacts,
    };

    return select * from only $fp;
};

define function overwrite fn::delete_focal_person($fp: record<focal_person>){
    let $foc = select * from only $fp;
    if(!$foc){
        throw "invalid request";
    };

    let $docs = select * from saudi_visas_document where focal_person = $fp;

    if(array::len($docs) > 0){
        throw "Documents belong to this focal person";
    };

    delete $fp;

    return true;
};


define function overwrite fn::add_svd_job(
    $svd: record<saudi_visas_document>, 
    $saudi_job: record<saudi_job>, 
    $jobs_count: int, 
    $embassy: string
){
    create only svd_job content {
            svd: $svd,
            job: (select * from only $saudi_job),
            jobs_count: $jobs_count,
            embassy: $embassy,
    };

    return fn::get_full_svd($svd);
};


define function overwrite fn::remove_job_from_svd_job(
    $svd_job_id: record<svd_job>, 
    $remove_count: int, 
){
    let $svd_job = select * from only $svd_job_id;
    let $assigned_jobs = select * from svp_assigned_job where svd_job=$svd_job.id;

    let $available_jobs = $svd_job.jobs_count - array::len($assigned_jobs);
    
    if($available_jobs < $remove_count){
        throw "not enough jobs"
    };

    update only $svd_job_id merge {
          jobs_count: $svd_job.jobs_count - $remove_count,  
    };

    let $svd_job = select * from only $svd_job.id;
    
    if($svd_job.jobs_count == 0){
        delete $svd_job.id;
    };

    return fn::get_full_svd($svd_job.svd);
    
};


define function overwrite fn::get_full_svp($svp_id: record<saudi_visa_process>){
    let $svp = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from only $svp_id;

            return $svp;
};



define function overwrite fn::get_all_svps_full(){
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from saudi_visa_process where status="active"
                order by created_at desc;

    return $svps;
    
};

define function overwrite fn::svps::get_all_completed_uninvoiced_svps_full(){
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from saudi_visa_process where status="completed" and item_unit.invoiced=false
                order by created_at desc;

    return $svps;
    
};

define function overwrite fn::svps::get_all_completed_svps_full(){
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from saudi_visa_process where status="completed"
                order by completed_at desc;

    return $svps;
    
};


define function overwrite fn::svps::get_all_svps_full(){
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from saudi_visa_process
                order by created_at desc;

    return $svps;
    
};




define function overwrite fn::svps::get_all_svps_full_by_document($svd_id: record<saudi_visas_document>){
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from saudi_visa_process where status="active" and svd=$svd_id
                order by created_at desc;

    return $svps;
    
};



define function overwrite fn::get_full_svd($svd_id: record<saudi_visas_document>){
    let $svd = select *, focal_person.*,
        (select * from svd_job where svd=$parent.id) as jobs,
        {
            assigned_jobs: (select * from svp_assigned_job where svd=$parent.id),
        } as extra
    from only $svd_id;

    return $svd;
};




define function overwrite fn::get_all_svds_full(){
    let $svds = select *, focal_person.*,
        (select * from svd_job where svd=$parent.id) as jobs,
        {
            assigned_jobs: (select * from svp_assigned_job where svd=$parent.id),
        } as extra
        from saudi_visas_document
        order by created_at desc;
    return $svds;
};

define function overwrite fn::get_active_svds_full(){
    let $svds = select *, focal_person.*,
        (select * from svd_job where svd=$parent.id) as jobs,
        {
            assigned_jobs: (select * from svp_assigned_job where svd=$parent.id),
        } as extra
        from saudi_visas_document
        where completed = false
        order by created_at desc;
    return $svds;
};


define function overwrite fn::svp::get_critical_svps(){
    let $today = time::floor(time::now(), 1d) ;
    let $svps_tasks = select value meta.svp as svp from task 
                        where meta.svp != None and
                        $today >= (time::floor(deadline, 1d) - (duration::from::days(last_critical_days)));
                        
                        ;
    let $svps = select *,
              (select *,
                (select *, transaction.* from item_unit_part where unit=$parent.id) as parts 
              from only $parent.item_unit) as item_unit,
              
              (select *, svd_job.* from only $parent.assigned_job) as assigned_job,
              (fn::get_full_svd($parent.svd)) as svd, 
                 profile.* 
                from $svps_tasks;

    return $svps;
};
