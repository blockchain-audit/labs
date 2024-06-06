use debug::PrintTrait;
use array::ArrayTrait;
use dict::Felt252DictTrait;
use core::panic_with_felt252;



fn rotateImage(imageData: @Array<u256>, degrees:u256) -> Array<u256> {
  
    // Extract image dimensions assuming a square image
    let width = 5; //imageData.len() / 4;
    let height = width;
  
    // Create a new array to store the rotated image data
    let mut rotatedImage :Array<u256> = ArrayTrait::new(); //[imageData.len()];

    let mut rotatedImage_dict = felt252_dict_new::<u32>();

    // Define rotation logic based on degrees (handle 90 and 270 for simplicity)
    if degrees == 90 {
        let mut i: u32 = 0;
        loop {
            if i == width { // Break condition
                break ();
            }
            let mut j: u32 = 0;
            loop{
                if j == height {
                    break ();
                }
                let newIndex: felt252 = ((j * width) + (width - i - 1)).into();
                let value = (*imageData.at(i * height + j)).try_into().unwrap();
                rotatedImage_dict.insert(newIndex, value);
                j = j + 1;
            };
            // Repeating code
            i = i + 1;
        };    
    } else if degrees == 270 {
        let mut i: u32 = 0;
        loop {
            if i == width { // Break condition
                break ();
            }
            let mut j: u32 = 0;
            loop{
                if j == height {
                    break ();
                }
                let newIndex: felt252 = (((height - j - 1) * width) + i).into();
                let value = (*imageData.at(i * height + j)).try_into().unwrap();
                rotatedImage_dict.insert(newIndex, value);
                j = j + 1;
            };
            // Repeating code
            i = i + 1;
        };    
    }
    rotatedImage
}


//main
fn main() {
    // let width: u32 = 10;
    // let height: u32 = 10;

    // let flag: bool = createGrayscaleImage(:width, :height);
}