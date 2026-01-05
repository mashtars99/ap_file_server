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
              decr: -1*$balance,
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


