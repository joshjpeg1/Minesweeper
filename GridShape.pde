/**
 * Represents all of the shapes that a grid can be.
 */
public enum GridShape {
  RECT("rect.png"), CIRCLE("circle.png"), TRIANGLE("triangle.png"), 
  HEXAGON("hexagon.png"), STAR("star.png"), LETTER("letter.png");
  
  private String fileName;
  
  /**
   * Constructs a new {@code GridShape} element.
   *
   * @param fileName   the name of the file to pull the shape from
   * @throws IllegalArgumentException if the given file name is uninitialized
   */
  private GridShape(String fileName) throws IllegalArgumentException {
    if (fileName == null) {
      throw new IllegalArgumentException("Given file name is uninitialized.");
    }
    this.fileName = fileName;
  }
  
  /**
   * Gets the name of the file to pull the shape from.
   *
   * @return the shape's file name
   */
  public String getFileName() {
    return this.fileName;
  }
}