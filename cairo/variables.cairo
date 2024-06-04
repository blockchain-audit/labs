fn main() {
    let immutable_var: felt252 = 17;
    // immutable_var = 38;  <-- fails to compile

    // but this is legal:
    let mut mutable_var: felt252 = immutable_var;
    mutable_var = 38;

    assert(mutable_var != immutable_var, 'mutable equals immutable');
}

#[test]
fn test_main() {
    main();
}