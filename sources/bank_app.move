module bank_app::bank_app {
    use std::string::String;
    use sui::table;
    use std::address;
    use sui::object::delete;
    use sui::table::drop;
    use sui::tx_context::dummy;

    const ERROR_BANK_NOT_FOUND: u64 = 1;
    const ERROR_ACCOUNT_NOT_FOUND: u64 = 2;
    // const ERROR_ACCOUNT_ALREADY_EXISTS: u64 = 3;
    // const ERROR_INVALID_PIN: u64 = 4;
    // const ERROR_INSUFFICIENT_FUNDS: u64 = 5;
    // const ERROR_DEPOSIT_THAN_ZERO: u64 = 6;

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

    
}









public fun dummy_drop(obj: Bank, user: address) {
    transfer::public_transfer(obj, user);
}

#[test]
public fun test_create_bank() {
    let mut ctx = dummy();
    let mut zenith_bank = create_bank(b"Zenith".to_string(), &mut ctx);
    assert!(zenith_bank.name == "Zenith" , ERROR_BANK_NOT_FOUND);
    dummy_drop(zenith_bank, 
    }
}
