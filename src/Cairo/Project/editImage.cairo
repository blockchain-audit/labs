#[derive(Copy, Clone, Debug)] // it's affordable to have Operation Copy/Clone
enum Operation {
    NoOp,
    AdjustColor,
    Transform, // further categorization is needed: flip(orientation), Rotate(i32), scale(factor)

    // the the rect surrounding the pixelated area, saved for restoration before next Pixelate
    Pixelate {top_x: u32, top_y: u32, width: u32, height: u32},
    BilateralFilter,

    // 2 areas aligning at the top/bottom edge need to be blurred, these 2 values are their height, saved for restoration before next miniaturze
    Miniaturize {top_height: u32, bottom_height: u32},
    GaussianBlur,
    Cartoonify,
}

#[wasm_bindgen]
 struct Image {
    width: u32,
    height: u32,
    pixels: Array<u8>,

    pixels_bk: Vec<u8>,
    width_bk: u32,
    height_bk: u32,

    last_operation: Operation,

    hsi: Vec<Vec<felt64>>, //  elements: Hue, Saturation, Intensity
    lab: Vec<felt64>, // L*a*b color space, used mostly in bilateral filter for calculating color difference. It'd get cleared when not used.
    // dct: (Vec<f64>, Vec<f64>),
}



fn rotate(mut self, clockwise: bool) { // rotate 90
    let (w, h) = (self.width as usize, self.height as usize);
    

    let mut new_pixels = vec![0_u8; w * h * 4];
    let mut new_x;
    let mut new_y;
    let mut new_idx: usize;
    let mut current_idx: usize;

    for row in 0..h {
        for col in 0..w {
            new_x = if clockwise { h - 1 - row } else { row };
            new_y = if clockwise { col } else { w - 1 - col };
            new_idx = new_y * h + new_x; // new image's height is original image's width
            current_idx = row * w + col;

            new_pixels[new_idx * 4 + 0] = self.pixels[current_idx * 4 + 0];
            new_pixels[new_idx * 4 + 1] = self.pixels[current_idx * 4 + 1];
            new_pixels[new_idx * 4 + 2] = self.pixels[current_idx * 4 + 2];
            new_pixels[new_idx * 4 + 3] = self.pixels[current_idx * 4 + 3];
        }
    }
    self.pixels = new_pixels;
    self.width = h as u32;
    self.height = w as u32;
    self.last_operation = Operation::Transform
}

pub fn rotate_by(&mut self) { // rotate by a specified degree
    // to be implemented
    self.last_operation = Operation::Transform
}





public class ImageRotator {

    /**
     * Rotates a given image 90 degrees clockwise.
     *
     * @param originalImage The original image represented as a 2D array of integers (pixel values).
     * @return A new 2D array of integers representing the rotated image.
     */
    public static int[][] rotateImage90DegreesClockwise(int[][] originalImage) {
        int width = originalImage.length;
        int height = originalImage[0].length;

        // Create a new array with swapped dimensions
        int[][] rotatedImage = new int[height][width];

        // Copy the pixels to the new array in rotated positions
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                rotatedImage[j][width - 1 - i] = originalImage[i][j];
            }
        }

        return rotatedImage;
    }

    public static void main(String[] args) {
        // Example usage
        int[][] rawImage = {
            {1, 2, 3},
            {4, 5, 6},
            {7, 8, 9}
        };

        int[][] rotatedImage = rotateImage90DegreesClockwise(rawImage);

        // Print rotated image
        for (int i = 0; i < rotatedImage.length; i++) {
            for (int j = 0; j < rotatedImage[i].length; j++) {
                System.out.print(rotatedImage[i][j] + " ");
            }
            System.out.println();
        }
    }
}



fn rotate_image(original_image: Array<Array<usize>>) -> Array<Array<usize>>{
    let width:
}
