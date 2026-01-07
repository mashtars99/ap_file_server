define table overwrite airline type normal schemaless permissions full;
define field overwrite key on airline type string;
define field overwrite name on airline type string;
define index overwrite unique_key on airline fields key unique;
define index overwrite unique_name on airline fields name unique;



define table overwrite airport type normal schemaless permissions full;
define field overwrite code on airport type string;
define field overwrite country_code on airport type string;
define field overwrite country_long_code on airport type string;
define field overwrite country_name on airport type string;
define field overwrite description on airport type string;
define field overwrite latitude on airport type string;
define field overwrite longitude on airport type string;
define field overwrite name on airport type string;

define index if not exists unique_code on airport fields code unique;


define function overwrite fn::add_airport(
    $code: string,
    $country_code: string,
    $country_long_code: string,
    $country_name: string,
    $description: string,
    $latitude: string,
    $longitude: string,
    $name: string

){

    return create only airport content {
        code: $code,
        country_code: $country_code,
        country_long_code: $country_long_code,
        country_name: $country_name,
        description: $description,
        latitude: $latitude,
        longitude: $longitude,
        name: $name,
    };

    
};

define function overwrite fn::add_airline(
    $key: string,
    $name: string
){

    return create only airline content{
        name: $name,
        key: $key,
    };
    
};

// updated from previous migration
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

    return update only $id merge {
        pnr: $pnr,
        passengers: $passengers,
        sectors: $sectors,
        refunded: $refund,
    };
    
};
