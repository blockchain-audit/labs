use debug::PrintTrait;

fn main(x: felt252, y: felt252){
    assert(x!=y, 'error,x is equal to y');
}


#[test]
fn test_main() {
    
    main(1,2);
}