// fn main(){
//     // max value of felt252
//     let x: felt252 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
//     let y: felt252 = 1; 
//     assert(x + y == 0, 'P == 0 (mod P)');
// } 

// since felt252 is the default data type, so we don't need to write the specific type before.
fn main(){
    // max value of felt252
    let x = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let y = 1;
    let r = x + y; // if you have overflow so it's equal to 0
    // Field elements have the property of intentionally wrapping around when their value falls outside the specified range.
    // That is, they use modular arithmetic.
    assert(x + y == r, 'P == 0 (mod P)'); 
}

// felt252:

// size: 252bits.

// Range: 0 to 2 ** 251 - 1 for non -negative values

// Operations: Supports arithmetic operations, 
// including handling negative literals due to the nature of field elements in modular arithmetic.
