/**
 * Represents a single cell on a grid.
 */
public class Cell {
  public static final int MINE = -1;
  
  private Posn posn;
  private CellState state;
  private int value;
  
  /**
   * Constructs a new cell on the grid at the given position.
   *
   * @param posn   the position of the new cell
   * @throws IllegalArgumentException if the given position is
   *                                  uninitialized
   */
  public Cell(Posn posn) throws IllegalArgumentException {
    if (posn == null) {
      throw new IllegalArgumentException("Given position is uninitialized.");
    }
    this.posn = posn;
    this.state = CellState.CLOSED;
    this.value = 0;
  }
  
  public Cell(Cell other) {
    if (other == null) {
      throw new IllegalArgumentException("Given cell is uninitialized.");
    }
    this.posn = other.posn;
    this.state = other.state;
    this.value = other.value;
  }
  
  public void setValue(int value) {
    this.value = value;
  }
  
  public int getValue() {
    return this.value;
  }
  
  public Posn getPosition() {
    return new Posn(this.posn);
  }
  
  public CellState getState() {
    return this.state;
  }
  
  public void setState(CellState state) {
    if (state == null) {
      throw new IllegalArgumentException();
    }
    this.state = state;
  }
  
  @Override
  public String toString() {
    return "(" + this.posn.getX() + ", " + this.posn.getY() + ", " + this.value + ")";
  }
  
  /**
   * Displays the given cell on the grid.
   *
   * @param cellSize   the size of the cell
   * @throws IllegalArgumentException if the given cell size is 
   *                                  zero or negative
   */
  public void display(int top, int cellSize) {
    int x = this.posn.getX();
    int y = this.posn.getY();
    noStroke();
    if (this.state.equals(CellState.OPENED)) {
      shapeMode(CENTER);
      stroke(80);
      fill(150);
      rect(x * cellSize, top + (y * cellSize), cellSize, cellSize);
      fill(255, 0, 0);
      if (this.value == MINE) {
        ellipse((x + 0.5) * cellSize, top + ((y + 0.5) * cellSize), cellSize / 2, cellSize / 2);
      } else if (this.value > 0)  {
        textSize(20);
        textAlign(CENTER, BOTTOM);
        text(Integer.toString(this.value), (x * cellSize) + (cellSize * 0.5), top + ((y + 1) * cellSize));
      }
    } else {
      fill(255);
      triangle(x * cellSize, top + (y * cellSize),
              (x + 1) * cellSize, top + (y * cellSize),
              (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
      fill(0);
      triangle(x * cellSize, top + ((y + 1) * cellSize),
              (x + 1) * cellSize, top + ((y + 1) * cellSize),
              (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
      fill(80);
      triangle((x + 1) * cellSize, top + (y * cellSize),
              (x + 1) * cellSize, top + ((y + 1) * cellSize),
              (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
      fill(180);
      triangle(x * cellSize, top + (y * cellSize),
               x * cellSize, top + ((y + 1) * cellSize),
              (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
      fill(150);
      shapeMode(CENTER);
      rect((x + 0.15) * cellSize, top + ((y + 0.15) * cellSize), cellSize * 0.7, cellSize * 0.7);
    }
  }
}