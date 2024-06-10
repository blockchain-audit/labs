use debug::PrintTrait;
use array::ArrayTrait;
use dict::Felt252DictTrait;
use core::panic_with_felt252;
// fn createGrayscaleImage(width:u32, height:u32) -> bool {
//         Create a 10x10 grayscale image with values ranging from 0 to 255
//         int[][] image = {
//             {255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
//             {255, 200, 200, 200, 200, 200, 200, 200, 200, 255},
//             {255, 200, 150, 150, 150, 150, 150, 150, 200, 255},
//             {255, 200, 150, 100, 100, 100, 100, 150, 200, 255},
//             {255, 200, 150, 100,  50,  50, 100, 150, 200, 255},
//             {255, 200, 150, 100,  50,  50, 100, 150, 200, 255},
//             {255, 200, 150, 100, 100, 100, 100, 150, 200, 255},
//             {255, 200, 150, 150, 150, 150, 150, 150, 200, 255},
//             {255, 200, 200, 200, 200, 200, 200, 200, 200, 255},
//             {255, 255, 255, 255, 255, 255, 255, 255, 255, 255}
//         };
//         byte[] imageData = new byte[width * height];
//         int index = 0;
//         for (int y = 0; y < height; y++) {
//             for (int x = 0; x < width; x++) {
//                 imageData[index++] = (byte) image[y][x];
//             }
//         }
//         true
//     }
fn rotateImage(imageData: @Array<u256>, degrees:u256) -> Array<u256> {
    
    let width = 5; 
    let height = width;
    
    let mut rotatedImage :Array<u256> = ArrayTrait::new(); 
    let mut rotatedImage_dict = felt252_dict_new::<u32>();
    
    if degrees == 90 {
        let mut i: u32 = 0;
        loop {
            if i == width { 
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
            
            i = i + 1;
        };
    } else if degrees == 270 {
        let mut i: u32 = 0;
        loop {
            if i == width { 
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
            
            i = i + 1;
        };
    }
    rotatedImage
}