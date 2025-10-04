module bank_app::bank_app {

    use std::string::String;
    use sui::table;
    use std::address;


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

    public struct Bank has key, store {
        id: UID,
        name: String,
        accounts: table::Table<address, Account>,jjkk
    }

    public fun create_bank(name: String, ctx: &mut TxContext): Bank {
        let id = object::new(ctx);
        let accounts = table::new<address, Account>(ctx);

        Bank {
            id,
            name,
            accounts,
        }
    }

    #[test]
    public fun test_create_bank() {

        let mut zenith_bank = create_bank(b"Zenith".to_string(), &mut ctx);
        assert!(zenith_bank.name == b"Zenith".to_string(), ERROR_BANK_NOT_FOUND);
        assert!(!zenith_bank.name == b"Zenith".to_string(), ERROR_ACCOUNT_NOT_FOUND);
    };
    
    

}

