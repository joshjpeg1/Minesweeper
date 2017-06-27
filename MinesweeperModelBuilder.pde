public class MinesweeperModelBuilder {
  private int size = 10;
  private GridShape shape = GridShape.RECT;
  
  public MinesweeperModelBuilder setSize(int size) {
    if (size < 8 || size > 25) {
      println(size);
      return this;
    }
    this.size = size;
    println(this.size + " : " + this.shape.getFileName());
    return this;
  }
  
  public int getSize() {
    return this.size;
  }
  
  public MinesweeperModelBuilder setShape(GridShape shape) {
    if (shape == null) {
      return this;
    }
    this.shape = shape;
    println(this.size + " : " + this.shape.getFileName());
    return this;
  }
  
  public GridShape getShape() {
    return this.shape;
  }
  
  public MinesweeperOperations build() {
    return new MinesweeperModel(this);
  }
}