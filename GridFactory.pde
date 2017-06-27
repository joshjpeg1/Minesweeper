/**
 * Factory class for creating new grids of different shapes.
 */
public class GridFactory {
  /**
   * Generates a 2-dimensional array of booleans of the given size,
   * to be represented in the given shape.
   *
   * @param side    the size of a single side of the array
   * @param shape   the shape the true booleans in the array form
   * @return a 2-dimensional boolean array of the given size and shape
   */
  public Boolean[][] generate(int side, GridShape shape) {
    if (side < 8 || side > 25) {
      throw new IllegalArgumentException("Cannot generate grid width "
          + "side length less than 8 or greater than 25.");
    } else if (shape == null) {
      throw new IllegalArgumentException("Invalid grid shape.");
    }
    PImage imgShape = loadImage(shape.getFileName());
    imgShape.resize(side, side);
    return buildGrid(imgShape);
  }
  
  /**
   * Helper to the generate method.
   * Builds a grid of booleans using an image as a base for where cells
   * should be placed. A true boolean in the array represents where a
   * cell is, while a false boolean in the array represents where nothing
   * exists.
   */
  private Boolean[][] buildGrid(PImage img) {
    int side = img.width;
    Boolean[][] grid = new Boolean[side][side];
    for (int y = 0; y < side; y++) {
      for (int x = 0; x < side; x++) {
        color c = img.pixels[x + (y * side)];
        grid[x][y] = (c == color(255));
      }
    }
    return grid;
  }
}