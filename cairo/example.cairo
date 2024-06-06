use debug::PrintTrait;
use array::ArrayTrait;


fn main(){
    let mut arr :Array<felt252> = ArrayTrait::new();
    arr.append(1);
    arr.append(2);
    arr.append(3);
    let x :felt252=1;
    assert(*arr[0] == 1 &&*arr[1] == 2 && *arr[2] == 3, 'wkuyt');
    'jhgvhfbjd'.print();
}

#[test]
fn test_main() {
    main();
}

fn add (x : felt252, y : felt252) -> felt252 {
    return  x+y;
}





