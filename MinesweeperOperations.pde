import java.util.List;

/**
 * Represents all operations that a game of Minesweeper should have,
 * including play, open, flag, isGameOver, and getter methods for the
 * different cells and states of the game.
 */
public interface MinesweeperOperations {
  /**
   * Starts the game.
   */
  void play();
  
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
  
  /**
   * Gets all of the cells on the grid as a list.
   *
   * @return a list of all cells on the grid
   */
  List<Cell> getCells();
  
  /**
   * Gets the size of the grid.
   *
   * @return the size of the grid
   */
  int getSize();
  
  /**
   * Gets the number of flags left.
   *
   * @return the number of flags left
   */
  int getFlags();
  
  /**
   * Gets the number of moves made so far.
   *
   * @return the number of moves made
   */
  int getNumMoves();
  
  /**
   * Gets the current time in-game (measured in seconds).
   *
   * @return the current in-game time
   */
  int getTime();
  
  /**
   * Gets the current state of the game.
   *
   * @return the current state of the game
   */
  GameState getState();
  
  /**
   * Sets the state of the game to the given state.
   *
   * @throws IllegalArgumentException if the given state is uninitialized
   */
  void setGameState(GameState state) throws IllegalArgumentException;
}