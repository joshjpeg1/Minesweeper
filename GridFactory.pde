/**
 * Factory class for creating new grids of different shapes.
 */
public class GridFactory {
  /**
   * Generates a 2-dimensional array of booleans
   */
  public Boolean[][] generate(int side, GridShape shape) {
    if (side < 8) {
      throw new IllegalArgumentException("Cannot generate grid width "
          + "side length less than 8.");
    } else if (shape == null) {
      throw new IllegalArgumentException("Invalid grid shape.");
    }
    PImage imgShape = loadImage(shape.getFileName());
    imgShape.resize(side, side);
    return buildGrid(imgShape);
  }
  
  private Boolean[][] buildGrid(PImage img) {
    int side = img.width;
    Boolean[][] grid = new Boolean[side][side];
    //image(img, width/2, height/2);
    for (int y = 0; y < side; y++) {
      for (int x = 0; x < side; x++) {
        color c = img.pixels[x + (y * side)];
        grid[x][y] = (c == color(255));
        print((c == color(255)) ? "◻" : "◼");
        print(" ");
      }
      print("\n");
    }
    return grid;
  }
}