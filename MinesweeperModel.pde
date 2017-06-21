import java.util.Random;

/**
 * Represents a model of the Minesweeper game, using all of the operations
 * of the {@link MinesweeperOperations} interface.
 */
public class MinesweeperModel implements MinesweeperOperations {
  private Cell[][] cells;
  private int size;
  private final Random rand;
  private GameState state;
  private int flags;
  private int moves;
  
  public MinesweeperModel() {
    this.rand = new Random();
    this.state = GameState.PLAYING;
  }
  
  @Override
  public void generate(int size, GridShape shape) throws IllegalArgumentException {
    this.size = size;
    Boolean[][] arr = new GridFactory().generate(size, shape);
    this.cells = new Cell[this.size][this.size];
    for (int x = 0; x < this.size; x++) {
      for (int y = 0; y < this.size; y++) {
        if (!arr[x][y]) {
          this.cells[x][y] = new Cell(new Posn(x, y));
        }
      }
    }
    this.addMines();
    this.updateCells();
    this.moves = 0;
  }
  
  private void addMines() {
    int numMines = this.getCells().size() / 10;
    List<Posn> mines = new ArrayList<Posn>();
    for (int i = 0; i < numMines; i++) {
      while (true) {
        int x = rand.nextInt(this.size);
        int y = rand.nextInt(this.size);
        Posn mine = new Posn(x, y);
        if (!mines.contains(mine) && this.cells[x][y] != null) {
          mines.add(mine);
          break;
        }
      } 
    }
    this.flags = mines.size();
    for (Posn mineLoc : mines) {
      this.cells[mineLoc.getX()][mineLoc.getY()].setValue(Cell.MINE);
    }
  }
  
  private void updateCells() {
    List<Cell> cellList = this.getCells();
    for (Cell c : cellList) {
      if (c.getValue() == Cell.MINE) {
        int x = c.getPosition().getX();
        int y = c.getPosition().getY();
          this.increaseCell(x - 1, y - 1);
          this.increaseCell(x - 1, y);
          this.increaseCell(x - 1, y + 1);
          this.increaseCell(x, y - 1);
          this.increaseCell(x, y);
          this.increaseCell(x, y + 1);
          this.increaseCell(x + 1, y - 1);
          this.increaseCell(x + 1, y);
          this.increaseCell(x + 1, y + 1);
        }
    }
  }
  
  private void increaseCell(int x, int y) {
    try {
      Cell c = this.cells[x][y];
      if (c.getValue() != Cell.MINE) {
        c.setValue(c.getValue() + 1);
      }
    } catch (IndexOutOfBoundsException e) {
      // do nothing, cell outside of bounds
    } catch (NullPointerException e) {
      // do nothing, cell does not exist
    }
  }
  
  @Override
  public void open(int x, int y) throws IllegalArgumentException {
    this.checkGameOver();
    try {
      Cell c = this.cells[x][y];
      if (c.getValue() == 0) {
        this.openNeighbors(x, y);
      } else {
        c.setState(CellState.OPENED);
        if (c.getValue() == Cell.MINE) {
          for (Cell cell : this.getCells()) {
            if (cell.getValue() == Cell.MINE) {
              cell.setState(CellState.OPENED);
            }
          }
          this.state = GameState.GAMEOVER;
        }
      }
      this.moves += 1;
    } catch (IndexOutOfBoundsException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    } catch (NullPointerException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    }
  }
  
  private void openNeighbors(int x, int y) {
    Cell c;
    try {
      c = this.cells[x][y];
    } catch (IndexOutOfBoundsException e) {
      // do nothing, cell outside of bounds
      return;
    } catch (NullPointerException e) {
      // do nothing, cell does not exist
      return;
    }
    if (c.getValue() == Cell.MINE) {
      return;
    }
    if (!c.getState().equals(CellState.OPENED)) {
      c.setState(CellState.OPENED);
      if (c.getValue() == 0) {
        this.openNeighbors(x - 1, y);
        this.openNeighbors(x + 1, y);
        this.openNeighbors(x, y - 1);
        this.openNeighbors(x, y + 1);
      }
    }
  }
  
  @Override
  public void flag(int x, int y) throws IllegalArgumentException {
    this.checkGameOver();
    try {
      Cell c = this.cells[x][y];
      switch (c.getState()) {
        case OPENED: 
          break;
        case CLOSED:
          if (this.flags > 0) {
            this.flags -= 1;
            c.setState(CellState.FLAGGED);
          } else {
            c.setState(CellState.QUESTIONED);
          }
          break;
        case FLAGGED:
          this.flags += 1;
          c.setState(CellState.QUESTIONED);
          break;
        case QUESTIONED:
          c.setState(CellState.CLOSED);
          break;
        default:
          throw new IllegalArgumentException("State does not exist.");
      }
      this.moves += 1;
    } catch (IndexOutOfBoundsException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    } catch (NullPointerException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    }
  }
  
  private void checkGameOver() throws IllegalStateException {
    if (this.isGameOver()) {
      throw new IllegalStateException("Game is over.");
    }
  }
  
  @Override
  public boolean isGameOver() {
    int mines = 0;
    int openedCells = 0;
    List<Cell> allCells = this.getCells();
    for (Cell c : allCells) {
      if (c.getValue() == Cell.MINE) {
        if (c.getState().equals(CellState.OPENED)) {
          return true;
        }
        mines += 1;
      } else if (c.getState().equals(CellState.OPENED)) {
        openedCells += 1;
      }
    }
    if (allCells.size() - mines == openedCells) {
      return true;
    }
    return false;
  }
  
  @Override
  public List<Cell> getCells() {
    List<Cell> cellsList = new ArrayList<Cell>();
    for (int x = 0; x < cells.length; x++) {
      for (int y = 0; y < cells[x].length; y++) {
        if (cells[x][y] != null) {
          cellsList.add(cells[x][y]);
        }
      }
    }
    return cellsList;
  }
  
  @Override
  public int getSize() {
    return this.size;
  }
  
  @Override
  public int getFlags() {
    return this.flags;
  }
  
  @Override
  public int getNumMoves() {
    return this.moves;
  }
}