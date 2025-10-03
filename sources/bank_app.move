module bank_app::bank_app {

    use std::string::String;
    use sui::table;


    const ERROR_ACCOUNT_NOT_FOUND: u64 = 0;

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
        let bank_id: UID = object::new(ctx: ctx);
        let accounts_table: table::Table<String, Account> = table::new<String>(ctx);

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

