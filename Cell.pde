/**
 * Represents a single cell on a grid.
 */
public class Cell {
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
  public Cell(Posn posn) {
    this.posn = posn;
    this.state = CellState.CLOSED;
    this.value = 0;
  }
  
  /**
   * Displays the given cell on the grid.
   *
   * @param cellSize   the size of the cell
   * @throws IllegalArgumentException if the given cell size is 
   *                                  zero or negative
   */
  public void display(int cellSize) {
    
  }
}