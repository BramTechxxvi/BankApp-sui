module bank_app::bank_app {
    use std::string::String;
    use sui::table;

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
    }

    #[test]
    public fun test_create_bank(ctx: &mut TxContext) {
        let zenith_bank : Bank = create_bank("Zenith", bank_id, accounts_table);
    }
    

}

