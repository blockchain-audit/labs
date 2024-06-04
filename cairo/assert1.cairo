// To make sure our tests work, we use assert

fn main(x: felt252, y: felt252) {
    assert(x != y, 'error, x is equal to y');
}

// [TEST] 
// fn test_main() {
//     main(1, 2);
// }
