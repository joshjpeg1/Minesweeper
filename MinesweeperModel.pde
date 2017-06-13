/**
 * Represents a model of the Minesweeper game, using all of the operations
 * of the {@link MinesweeperOperations} interface.
 */
public class MinesweeperModel implements MinesweeperOperations {
  
  @Override
  public void generate(int size, GridShape shape) throws IllegalArgumentException {
    new GridFactory().generate(size, shape);
    return;
  }
  
  @Override
  public void open(int x, int y) throws IllegalArgumentException {
    return;
  }
  
  @Override
  public void flag(int x, int y) throws IllegalArgumentException {
    return;
  }
  
  @Override
  public void question(int x, int y) throws IllegalArgumentException {
    return;
  }
  
  @Override
  public boolean isGameOver() {
    return false;
  }
}