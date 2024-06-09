// // import wasm_bindgen;
// // import web_sys;

use array::SpanTrait;
use option::OptionTrait;
use debug::PrintTrait;
use array::ArrayTrait;

#[derive(Drop)]
struct Img{
    width: u32,
    height: u32
}


fn pixelate(self:@Img ,top_x: i32, top_Y: i32, p_width: u32, p_heigt: u32, block_size: u32 , blur_type: felt252){
    let img_width = self.width;
    let img_height = self.height;

}

fn mul(width: u64, height: u64) -> u64 {
    width * height
} 

fn rotate(self: @Img, clockwise: bool){ //rotate 90
    let w = self.width;
    let h = self.height;
    //let len: u64 = mul(*w, *h);
}




// fn rotate(&mut self, clockwise: bool) { // rotate 90
//     let (w, h) = (self.width as usize, self.height as usize);

//     let mut new_pixels = vec![0_u8; w * h * 4];
//     let mut new_x;
//     let mut new_y;
//     let mut new_idx: usize;
//     let mut current_idx: usize;

//     for row in 0..h {
//         for col in 0..w {
//             new_x = if clockwise { h - 1 - row } else { row };
//             new_y = if clockwise { col } else { w - 1 - col };
//             new_idx = new_y * h + new_x; // new image's height is original image's width
//             current_idx = row * w + col;

//             new_pixels[new_idx * 4 + 0] = self.pixels[current_idx * 4 + 0];
//             new_pixels[new_idx * 4 + 1] = self.pixels[current_idx * 4 + 1];
//             new_pixels[new_idx * 4 + 2] = self.pixels[current_idx * 4 + 2];
//             new_pixels[new_idx * 4 + 3] = self.pixels[current_idx * 4 + 3];
//         }
//     }
//     self.pixels = new_pixels;
//     self.width = h as u32;
//     self.height = w as u32;
//     self.last_operation = Operation::Transform
// }
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

fn main(){
    let img = Img{ width: 100, height: 100 };
    pixelate(@img, 12, 12, 12, 12, 12, '2');
    rotate(@img, true);
    'Hello, world!'.print();
}









// import stdlib;
// use debug::PrintTrait;
// let vec: Vec<u32>;


//sudo apt-get install libcairo2-dev
