public class DrawUtils {
  /**
   * Fits the given image to the desired dimensions.
   * 
   * @param img         the image to be fitted
   * @param maxWidth    the maximum width of the image
   * @param maxHeight   the maximum height of the image
   * @return the fitted image
   * @throws IllegalArgumentException if img is uninitialized, or if the
   * maxWidth or maxHeight are negative
   */
  public PImage fitImage(PImage img, int maxWidth, int maxHeight) throws IllegalArgumentException {
    if (img == null || maxWidth < 0 || maxHeight < 0) {
      System.out.println(maxWidth + " " + maxHeight);
      throw new IllegalArgumentException("Cannot use uninitialized images or negative dimensions.");
    }
    int imgWidth = img.width;
    int imgHeight = img.height;
    // scales an image's height in order to fit the max width
    if (imgWidth > maxWidth && imgWidth > 0) {
      float scaleRatio = float(maxWidth) / float(imgWidth);
      imgWidth = maxWidth;
      imgHeight = int(imgHeight * scaleRatio);
    }
    // scales an image's width in order to fit the max height
    if (imgHeight > maxHeight && imgHeight > 0) {
      float scaleRatio = float(maxHeight) / float(imgHeight);
      imgHeight = maxHeight;
      imgWidth = int(imgWidth * scaleRatio);
    }
    // resizes the image to the new width and height
    img.resize(imgWidth, imgHeight);
    return img;
  }
  
  public String padNumber(int number, int spaces) {
    String numStr = Integer.toString(number);
    while (numStr.length() < spaces) {
      numStr = "0" + numStr;
    }
    return numStr;
  }
}