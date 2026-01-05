
define function overwrite fn::get_cash_in_banks(){
    let $balances = select value asset_account.balance as balance from bank_account;
    return math::sum($balances);
};

