use debug::PrintTrait;

fn main() -> u128 {
    let mut i: u128 = 0;
    loop {
        if i > 9 { 
            break ();
        }
        'hello'.print(); 
        i = i + 1;
    };
    i
}

#[test]
#[available_gas(200000)] 
fn test_main() {
    let a = main();
    assert(a == 10, ' incorrect loop value ');
}