se debug::PrintTrait;
use array::ArrayTrait;
use dict::Felt252DictTrait;
use core::panic_with_felt252;

fn rotate_image(arr: Array<u256>, width: u256) -> Array<u256> {
   
   let mut rotatedImage :Array<u256> = ArrayTrait::new()
   let mut i: u256 = 0;
   let mut j: u256 = width - 1;
   
   let length_i: u256 = arr.len() - width;
   loop{
    if i >  length_i { 
        break ();
    }
      loop{
        if i > j {
            break ();
        }
        a.append(*arr.at(j));
        j - 1;
      };
      i + width;
      j = i + width-1;
   };
   a
}

