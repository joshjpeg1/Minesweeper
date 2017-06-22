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
}