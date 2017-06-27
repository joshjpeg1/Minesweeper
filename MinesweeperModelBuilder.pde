/**
 * Represents a builder class for a {@code MinesweeperModel}.
 */
public class MinesweeperModelBuilder {
  private int size = 20;
  private GridShape shape = GridShape.RECT;
  
  /**
   * Sets the size of the to-be model to the given size.
   * Limits the size of the model to a minimum of 8 and
   * a maximum of 25.
   * 
   * @return this builder
   */
  public MinesweeperModelBuilder setSize(int size) {
    this.size = Math.min(Math.max(8, size), 25);
    return this;
  }
  
  /**
   * Gets the current size in this builder's configuration
   * for a model.
   *
   * @return the currently set size
   */
  public int getSize() {
    return this.size;
  }
  
  /**
   * Sets the shape of the to-be model to the given shape.
   * Will ignore if given shape is uninitialized.
   * 
   * @return this builder
   */
  public MinesweeperModelBuilder setShape(GridShape shape) {
    if (shape != null) {
      this.shape = shape;
    }
    return this;
  }
  
  /**
   * Gets the current shape in this builder's configuration
   * for a model.
   *
   * @return the currently set shape
   */
  public GridShape getShape() {
    return this.shape;
  }
  
  /**
   * Builds a new {@code MinesweeperModel} with this configuration.
   *
   * @return a new model with this builder's configuration
   */
  public MinesweeperOperations build() {
    return new MinesweeperModel(this);
  }
}