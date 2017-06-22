import java.util.List;

/**
 * Represents all operations that a game of Minesweeper should have.
 */
public interface MinesweeperOperations {
  /**
   * Generates a grid of cells at the given size in the arrangement of
   * the given shape.
   *
   * @param size    the size of one side of the grid
   * @param shape   the shape of the grid of cells
   * @throws IllegalArgumentException if the size is less than 20, or
   *                                  the given shape is uninitialized
   */
  void generate(int size, GridShape shape) throws IllegalArgumentException;
  
  /**
   * Opens the cell at the given x and y coordinates on the grid.
   * If the cell is empty (no number), this should also open
   * all surrounding neighbors.
   * If the cell is not-empty (number), it should only open that space.
   * If the cell is a mine, it should open all mines on the grid.
   *
   * @param x   the x-coordinate of the cell
   * @param y   the y-coordinate of the cell
   * @throws IllegalArgumentException if there is no cell at the given
   *                                  position, or if the cell is 
   *                                  already opened
   */
  void open(int x, int y) throws IllegalArgumentException;
  
  /**
   * Flags the cell at the given x and y coordinates on the grid 
   * (user thinks it's a mine). Decreases flag count by one.
   *
   * @param x   the x-coordinate of the cell
   * @param y   the y-coordinate of the cell
   * @throws IllegalArgumentException if there is no cell at the given
   *                                  position, or if the cell is 
   *                                  already opened
   */
  void flag(int x, int y) throws IllegalArgumentException;
  
  /**
   * Checks if the game is over. There are two conditions that call
   * for a game over: if a mine has been opened, or if all of the cells
   * other than the mines have been opened.
   *
   * @return true if the game is over, false otherwise
   */
  boolean isGameOver();
  
  List<Cell> getCells();
  
  int getSize();
  
  int getFlags();
  
  int getNumMoves();
  
  int getTime();
  
  GameState getState();
  
  void setGameState(GameState state);
}