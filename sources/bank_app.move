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
    // const ERROR_ACCOUNT_ALREADY_EXISTS: u64 = 3;
    // const ERROR_INVALID_PIN: u64 = 4;
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
        dummy_drop(access_bank.name, @access_bank_address);
    }

}