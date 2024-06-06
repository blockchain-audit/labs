use debug::PrintTrait;
use array::ArrayTrait;
use dict::Felt252DictTrait;
use core::panic_with_felt252;


fn rotate_image(arr: @Array<u256>, width: u256) -> Array<u256> {
   let mut a :Array<u256> = ArrayTrait::new();
   let i: u32 = 0;
   let j = width - 1;
//    let length_i: u256 = arr.len() - width;
   loop{
    if j > arr.len() {
        break ();
    }
      loop{
        if i > j {
            break ();
        }
        a.append(*array.get(j).unwrap().unbox(););
        j - 1;
      };
      i + width;
      j = i + width-1;
   };
   a
}

let first_element = *array.get(0).unwrap().unbox();
