// public static int[][] rotateImage90DegreesClockwise(int[][] originalImage) {
//     int width = originalImage.length;
//     int height = originalImage[0].length;

//     // Create a new array with swapped dimensions
//     int[][] rotatedImage = new int[height][width];

//     // Copy the pixels to the new array in rotated positions
//     for (int i = 0; i < width; i++) {
//         for (int j = 0; j < height; j++) {
//             rotatedImage[j][width - 1 - i] = originalImage[i][j];
//         }
//     }

//     return rotatedImage;
//  public static int[][] rotateImage90DegreesClockwise(int[][] originalImage) {
//         int width = originalImage.length;
//         int height = originalImage[0].length;

//         // Create a new array with swapped dimensions
//         int[][] rotatedImage = new int[height][width];

//         // Copy the pixels to the new array in rotated positions
//         for (int i = 0; i < width; i++) {
//             for (int j = 0; j < height; j++) {
//                 rotatedImage[j][width - 1 - i] = originalImage[i][j];
//             }
//         }

//         return rotatedImage;
//     }