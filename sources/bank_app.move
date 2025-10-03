module bank_app::bank_app {
    use std::string::String;
    use std::table::Table;

    public struct Account {
        id: UID,
        name: String,
        pin: String,
        balance: u64,
    }

    public struct Bank {
        id: String,
        accounts: table::Table<String, Account>,
    }

    #[test]
    public fun test_create_bank(ctx: &mut TxContext) {
        
        };
    }   

}

