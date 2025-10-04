module bank_app::bank_app {

    use std::string::String;
    use sui::table;


    const ERROR_BANK_NOT_FOUND: u64 = 1;
    const ERROR_ACCOUNT_NOT_FOUND: u64 = 2;
    const ERROR_ACCOUNT_ALREADY_EXISTS: u64 = 3;
    const ERROR_INVALID_PIN: u64 = 4;
    const ERROR_INSUFFICIENT_FUNDS: u64 = 5;
    const ERROR_DEPOSIT_THAN_ZERO: u64 = 6;

    public struct Account has key, store {
        id: UID,
        name: String,
        pin: String,
        balance: u64,
    }

    public struct Bank has key {
        id: String,
        name: String,
        accounts: table::Table<String, Account>,
    }

    public fun create_bank(name: String, ctx: &mut TxContext): Bank {
        let bank_id = object::new(ctx: ctx);
        let accounts_table: tab = table::new<String>(ctx);

        Bank {
            id: bank_id,
            name: name,
            accounts: accounts_table,
        }
    }

    #[test]
    public fun test_create_bank(ctx: &mut TxContext) {
        let zenith_bank : Bank = create_bank("Zenith", bank_id, accounts_table);
    }
    

}

