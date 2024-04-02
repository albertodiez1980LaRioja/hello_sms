package tools.exprortSprite;

/**
 * Write a description of class main here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */

import java.awt.image.BufferedImage;

import javax.imageio.ImageIO;
import java.util.*;
import java.util.stream.*;
import java.nio.file.*;
import java.io.*;

public class exportSprite {
    private static Set<String> listFilesUsingFilesList(String dir) throws IOException {
        try (Stream<Path> stream = Files.list(Paths.get(dir))) {
            return stream
                    .filter(file -> !Files.isDirectory(file))
                    .map(Path::getFileName)
                    .map(Path::toString)
                    .collect(Collectors.toSet());
        }
    }

    private static boolean containsColor(int color, int[] colors) {
        for (int i = 0; i < 16; i++)
            if (colors[i] == color)
                return true;
        return false;
    }

    private static void exportPallete() {
        try {
            Set<String> files = listFilesUsingFilesList(".");
            for (String element : files) {
                if (element.charAt(element.length() - 1) == 'p' && element.charAt(element.length() - 2) == 'm'
                        && element.charAt(element.length() - 3) == 'b') {
                    System.out.println(element);
                    exportFilePallete(element);
                }
            }
        } catch (IOException e) {
            System.out.println("File no encontrado");
        }

    }

    private static void exportFilePallete(String filename) {
        BufferedImage img = null;
        try {
            img = ImageIO.read(new File(filename));
        } catch (IOException e) {
            System.out.println("File no encontrado");
        }
        // img= new BufferedImage(original.getWidth(), original.getHeight(),
        // BufferedImage.TYPE_3BYTE_BGR);
        int height = img.getHeight();
        int width = img.getWidth();
        System.out.print("Imagen cargada");
        int amountPixel = 0;
        int amountBlackPixel = 0;

        int rgb;
        int red;
        int green;
        int blue;

        double percentPixel = 0;
        int[] colors = new int[16];

        colors[0] = img.getRGB(0, 0);
        for (int h = 1; h < 16; h++) {
            colors[h] = -2;
        }
        int indexColor = 1;
        // System.out.println(height + " " + width + " " );

        for (int h = 0; h < height; h++) {
            for (int w = 0; w < width; w++) {
                amountPixel++;
                rgb = img.getRGB(w, h);
                if (!containsColor(rgb, colors)) {
                    colors[indexColor] = rgb;
                    indexColor++;
                }
                red = (rgb >> 16) & 0x000000FF;
                green = (rgb >> 8) & 0x000000FF;
                blue = (rgb) & 0x000000FF;
                if (red == 255 && green == 255 && blue == 255)
                    System.out.println("color blanco " + Integer.toString(rgb));
                if (/* red == 0 && green == 0 && blue == 0 */ rgb == colors[0]) {
                    amountBlackPixel++;
                }

            }
        }
        percentPixel = (double) amountBlackPixel / (double) amountPixel;

        System.out.println("amount pixel: " + amountPixel);
        System.out.println("amount black pixel: " + amountBlackPixel);
        System.out.println("amount pixel black percent: " + percentPixel);
        System.out.println("num colors: " + indexColor + " ");
        for (int i = 0; i < indexColor; i++) {
            rgb = colors[i];
            red = ((rgb >> 16) & 0x000000FF);
            green = ((rgb >> 8) & 0x000000FF);
            blue = ((rgb) & 0x000000FF);
            System.out.println("color: " + i + " " + red + " " + green + " " + blue);
        }
        try {
            FileWriter myWriter = new FileWriter("pallete.inc");
            FileWriter myWriterHex = new FileWriter("pallete.hex");
            myWriter.write(".db");
            for (int i = 0; i < indexColor; i++) {
                rgb = colors[i];
                red = normalizeColor((rgb >> 16) & 0x000000FF);
                green = normalizeColor((rgb >> 8) & 0x000000FF);
                blue = normalizeColor((rgb) & 0x000000FF);
                myWriter.write(" $" + colorSMS(red, green, blue));
                myWriterHex.write(" $" + colorSMS(red, green, blue));
            }
            myWriter.close();
            myWriterHex.close();
            System.out.println("Successfully wrote to the file.");
        } catch (Exception e) {

        }
    }

    static String colorSMS(int r, int g, int b) {
        int c = r / 85;
        c += (g / 85) * 4;
        c += (b / 85) * 16;
        System.out.println("" + c + " " + r + " " + g + " " + b);
        return String.format("%02x", c);
    }

    static int colorSMSInt(int r, int g, int b) {
        int c = r / 85;
        c += (g / 85) * 4;
        c += (b / 85) * 16;
        return c;
    }

    static int normalizeColor(int color) {
        if (color < 43)
            return 0;
        if (color < 128)
            return 85;
        if (color < 212)
            return 170;
        return 255;
    }

    
    private static int getIndexColor(BufferedImage img,int iw,int ih,int colors[]) {
        int rgb = img.getRGB(iw, ih);
        int red = normalizeColor((rgb >> 16) & 0x000000FF);
        int green = normalizeColor((rgb >> 8) & 0x000000FF);
        int blue = normalizeColor((rgb) & 0x000000FF);
        // get the color in palete and put value in hex
        int color = colorSMSInt(red, green, blue);
        int indexColor = 0;
        while (colors[indexColor] != color && indexColor < 16)
            indexColor++;
        if (indexColor == 16) {
            System.out.println("Color no encontrado");
            return -1;
        }
        //if (indexColor != 0)
        //    indexColor = 8;
        return indexColor;
    }

    private static int getPixelByRow(int row[]){
        int color = 0, mul = 8;
        for(int i=0;i<4;i++){
            color += row[i]*mul;
            mul = mul/2;
        }
        return color;
    }

    private static int getPixelByRowLow(int[] row){
        int color = 0, mul = 8;
        for(int i=4;i<8;i++){
            color += row[i]*mul;
            mul = mul/2;
        }
        return color;
    }


    private static void exportSpriteFile(String filename, int colors[]) {
        //
        BufferedImage img = null;
        try {
            img = ImageIO.read(new File(filename));
        } catch (IOException e) {
            System.out.println("File no encontrado");
        }
        // img= new BufferedImage(original.getWidth(), original.getHeight(),
        // BufferedImage.TYPE_3BYTE_BGR);
        int height = img.getHeight();
        int width = img.getWidth();
        System.out.print("Imagen cargada");
        if (height % 16 != 0) {
            System.out.println("El alto no es multiplo de 16 " + height);
            return;
        }
        if (width % 8 != 0) {
            System.out.println("El alto no es multiplo de 8 " + width);
            return;
        }
        try {
            FileWriter myWriter2 = new FileWriter("puno.inc");
            height = height / 16;
            width = width / 8;
            int tileIndex = 0;
            for (int h = 0; h < height; h++) {
                for (int w = 0; w < width; w++) {
                    myWriter2.write("; Tile index " + tileIndex + "\n");
                    tileIndex++;
                    myWriter2.write(".db ");
                    for (int ih = (h * 16); ih < ((h + 1) * 16); ih++) {
                        for (int iw = (w * 8); iw < ((w + 1) * 8); iw = iw + 8) {
                            int[][] matriz = new int[4][8];
                            int indexColorFinal=1;
                            for (int iPixel=0;iPixel<8;iPixel++){
                                indexColorFinal = getIndexColor(img, iw + iPixel, ih, colors);
                                matriz[0][iPixel] = (indexColorFinal & 1)/1;
                                matriz[1][iPixel] = (indexColorFinal & 2)/2;
                                matriz[2][iPixel] = (indexColorFinal & 4)/4;
                                matriz[3][iPixel] = (indexColorFinal & 8)/8;
                            }

                            myWriter2.write(" $");
                            myWriter2.write(String.format("%01x", getPixelByRow(matriz[0])));
                            myWriter2.write(String.format("%01x", getPixelByRowLow(matriz[0])));
                            myWriter2.write(" $");
                            myWriter2.write(String.format("%01x", getPixelByRow(matriz[1])));
                            myWriter2.write(String.format("%01x", getPixelByRowLow(matriz[1])));
                            myWriter2.write(" $");
                            myWriter2.write(String.format("%01x", getPixelByRow(matriz[2])));
                            myWriter2.write(String.format("%01x", getPixelByRowLow(matriz[2])));
                            myWriter2.write(" $");
                            myWriter2.write(String.format("%01x", getPixelByRow(matriz[3])));
                            myWriter2.write(String.format("%01x", getPixelByRowLow(matriz[3])));

                        }
                    }
                    myWriter2.write("\n");
                }
            }
            myWriter2.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
    }

    public static void main(String[] args) {
        System.out.println("Importador de imagenes, parámetros");
        for (int i = 0; i < args.length; i++) {
            System.out.print(i + " ");
            System.out.println(args[i].toString());
        }
        if (args.length >= 2) {
            // hay que convertirlo a una paleta lo mas cercana posible a una marter system,
            // va de 85 en 85: 0,85,170,255. En el bmp de test no salen exactos
            String[] colors = args[1].split(",");
            int[] colorsNumber = new int[16];
            for (int i = 0; i < colors.length; i++) {
                // int c = Integer.parseInt(colors[i].substring(2,3))*16;
                // c += Integer.parseInt(colors[i].substring(3,4));
                colorsNumber[i] = Integer.parseInt(colors[i].substring(2, 4), 16);
                System.out.println(colorsNumber[i]);
            }
            exportSpriteFile(args[0], colorsNumber);
        } else if (args.length == 1) {
            exportPallete();
        }

    }
}
