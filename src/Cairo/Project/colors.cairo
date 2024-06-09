import java.io.FileOutputStream;
import java.io.IOException;

public class SimpleGrayscaleImage {

    public static void createGrayscaleImage(String outputFile, int width, int height) throws IOException {
        // Create a 10x10 grayscale image with values ranging from 0 to 255
        int[][] image = {
            {255, 255, 255, 255, 255, 255, 255, 255, 255, 255},
            {255, 200, 200, 200, 200, 200, 200, 200, 200, 255},
            {255, 200, 150, 150, 150, 150, 150, 150, 200, 255},
            {255, 200, 150, 100, 100, 100, 100, 150, 200, 255},
            {255, 200, 150, 100,  50,  50, 100, 150, 200, 255},
            {255, 200, 150, 100,  50,  50, 100, 150, 200, 255},
            {255, 200, 150, 100, 100, 100, 100, 150, 200, 255},
            {255, 200, 150, 150, 150, 150, 150, 150, 200, 255},
            {255, 200, 200, 200, 200, 200, 200, 200, 200, 255},
            {255, 255, 255, 255, 255, 255, 255, 255, 255, 255}
        };

        byte[] imageData = new byte[width * height];
        int index = 0;
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                imageData[index++] = (byte) image[y][x];
            }
        }

        // Write the grayscale image to a raw file
        try (FileOutputStream fos = new FileOutputStream(outputFile)) {
            fos.write(imageData);
        }
    }

    public static void main(String[] args) {
        String outputFile = "simple_image.raw";
        int width = 10;
        int height = 10;

        try {
            createGrayscaleImage(outputFile, width, height);
            System.out.println("Grayscale image created successfully.");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("An error occurred while creating the image.");
        }

        // Now add a 3x3 black block in the middle of the image
        try {
            ImageProcessor.addBlackSquare(outputFile, "modified_image.raw", width, height);
            System.out.println("3x3 black square added successfully.");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("An error occurred while adding the black square.");
        }
    }
}