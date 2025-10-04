module bank_app::bank_app {
    use std::string::String;
    use sui::table;
    use std::address;
    use sui::object::delete;
    use sui::table::drop;
    use sui::tx_context::dummy;

    const ERROR_BANK_NOT_FOUND: u64 = 1;
    const ERROR_INVALID_BANK_NAME: u64 = 2;
    const ERROR_ACCOUNT_NOT_FOUND: u64 = 3;
    // const ERROR_INSUFFICIENT_FUNDS: u64 = 5;
    // const ERROR_DEPOSIT_THAN_ZERO: u64 = 6;

    #[allow(unused_field)]
    public struct Account has key, store {
        id: UID,
        name: String,
        pin: String,
        balance: u64,
    }

    public struct Bank has key, store {
        id: UID,
        name: String,
        accounts: table::Table<address, Account>,
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

    public fun dummy_drop(obj: Bank, user: address) {
        transfer::public_transfer(obj, user);
    }

    public fun create_account(name: String, pin: String, ctx: &mut TxContext): Account {
        let id = object::new(ctx);
        Account {
            id,
            name,
            pin,
            balance: 0,
        }
    }

    public fun add_account _to_bank 


    #[test]
    public fun test_create_bank() {
        let mut ctx = dummy();
        let mut zenith_bank = create_bank(b"Zenith".to_string(), &mut ctx);
        assert!(zenith_bank.name == b"Zenith".to_string() , ERROR_BANK_NOT_FOUND);
        assert!(zenith_bank.name != b"Access".to_string() , ERROR_INVALID_BANK_NAME);
        dummy_drop(zenith_bank, @zenith_bank_address);
    }

    #[test]
    public fun test_create_account() {
        let mut ctx = dummy();
        let mut access_bank = create_bank(b"Access".to_string(), &mut ctx);
        assert!(access_bank.name == b"Access".to_string() , ERROR_BANK_NOT_FOUND);
        assert!(access_bank.name != b"Zenith".to_string() , ERROR_INVALID_BANK_NAME);

        let bram_account = create_account(b"Bram".to_string(), b"1234".to_string(), &mut ctx);
        assert!(bram_account.name == b"Bram".to_string(), ERROR_ACCOUNT_NOT_FOUND);
        assert!(bram_account.pin == b"1234".to_string(), ERROR_ACCOUNT_NOT_FOUND);

        let user_address = @bram_address;
        table::add(&mut access_bank.accounts, user_address, bram_account);
        dummy_drop(access_bank, @access_bank_address);
    }

}