public class MinesweeperView {
  private int headerSize;
  private int cellSize;
  private MinesweeperOperations model;
  
  public MinesweeperView(MinesweeperOperations model) {
    this.headerSize = height - width;
    this.model = model;
  }
  
  public Posn getMousePosition(int mX, int mY) {
    return new Posn(mX / this.cellSize, (mY - this.headerSize) / this.cellSize);
  }
  
  public void display() {
    background(100);
    this.displayCells();
    this.displayHeader();
  }
  
  private void displayCells() {
    this.cellSize = width / model.getSize();
    List<Cell> cells = model.getCells();
    for (Cell c : cells) {
      c.display(headerSize, cellSize);
    }
  }
  
  private void displayHeader() {
    fill(200);
    rect(0, 0, width, this.headerSize);
    fill(255, 0, 0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text(this.model.getFlags(), 50, 50);
  }
}