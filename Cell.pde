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
   * @throws IllegalArgumentException if the given position is uninitialized
   */
  public Cell(Posn posn) throws IllegalArgumentException {
    if (posn == null) {
      throw new IllegalArgumentException("Given position is uninitialized.");
    }
    this.posn = posn;
    this.state = CellState.CLOSED;
    this.value = 0;
  }
  
  /**
   * Constructs a copy of the given cell.
   *
   * @param other   the cell to be copied
   * @throws IllegalArgumentException if the given cell is uninitialized
   */
  public Cell(Cell other) {
    if (other == null) {
      throw new IllegalArgumentException("Given cell is uninitialized.");
    }
    this.posn = other.posn;
    this.state = other.state;
    this.value = other.value;
  }
  
  @Override
  public String toString() {
    return "(" + this.posn.getX() + ", " + this.posn.getY() + ", " + this.value + ")";
  }
  
  /**
   * Gets the current position of this cell.
   * 
   * @return the current position of this cell
   */
  public Posn getPosition() {
    return new Posn(this.posn);
  }
  
  /**
   * Sets the value of this cell to the given value.
   * 
   * @param value   the new value of the cell
   */
  public void setValue(int value) {
    this.value = value;
  }
  
  /**
   * Gets the value of this cell.
   * 
   * @return the value of this cell
   */
  public int getValue() {
    return this.value;
  }
  
  /**
   * Sets the state of this cell to the given state.
   * 
   * @param state   the new state of the cell
   */
  public void setState(CellState state) {
    if (state == null) {
      throw new IllegalArgumentException();
    }
    this.state = state;
  }
  
  /**
   * Gets the current state of this cell.
   *
   * @return the current state of this cell
   */
  public CellState getState() {
    return this.state;
  }
}