fn main(x: felt252, y: felt252){ // like uint252-basicType in cairo
    assert(x != y, 'error, x is equal to y');
}

// must write test to run it
#[test]
fn test_main() {
    main(1, 2);
}