import java.util.Random;

/**
 * Represents a model of the Minesweeper game, using all of the operations
 * of the {@link MinesweeperOperations} interface.
 */
public class MinesweeperModel implements MinesweeperOperations {
  private Cell[][] cells;
  private int size;
  private GridShape shape;
  private final Random rand;
  private GameState state;
  private int flags;
  private int moves;
  private int start;
  private int timer;
  
  /**
   * Constructs a new {@code MinesweeperModel}.
   */
  public MinesweeperModel(MinesweeperModelBuilder builder) {
    this.rand = new Random();
    this.state = GameState.PLAYING;
    this.start = 0;
    this.timer = 0;
    this.size = builder.getSize();
    this.shape = builder.getShape();
  }
  
  @Override
  public void play() {
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
      this.firstMove(c);
      if (c.getValue() == 0) {
        this.openNeighbors(x, y);
      } else if (c.getState().equals(CellState.FLAGGED)){
        return;
      } else {
        updateFlags(c);
        c.setState(CellState.OPENED);
        if (c.getValue() == Cell.MINE) {
          for (Cell cell : this.getCells()) {
            if (cell.getValue() == Cell.MINE) {
              Posn cellPos = cell.getPosition();
              this.cells[cellPos.getX()][cellPos.getY()].setState(CellState.OPENED);
            }
          }
          this.state = GameState.LOSE;
        }
      }
      this.moves += 1;
    } catch (IndexOutOfBoundsException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    } catch (NullPointerException e) {
      throw new IllegalArgumentException("Cell does not exist at position.");
    }
  }
  
  /**
   * This method only runs if the user has just made its first move.
   * If the given cell is a mine, it will move the mine to the first available
   * space on the grid.
   * It will then update all cells, so that the number information is accurate.
   * Finally, it will start the timer.
   *
   * @param c   the first cell clicked in the game
   */
  private void firstMove(Cell c) {
    if (moves == 0) {
      if (c.getValue() == Cell.MINE) {
        c.setValue(0);
        Posn currPos = c.getPosition();
        for (Cell cell : this.getCells()) {
          Posn cellPos = cell.getPosition();
          if (!cellPos.equals(currPos)
              && cell.getValue() != Cell.MINE) {
            this.cells[cellPos.getX()][cellPos.getY()].setValue(Cell.MINE);
            break;
          }
        }
      }
      this.updateCells();
      startTimer();
    }
  }
  
  /**
   * Helper to the firstMove method. Starts the game timer.
   */
  private void startTimer() {
    start = millis();
    new Thread(new Runnable() {
      @Override
      public void run() {
        while(!isGameOver()) {
          timer = (millis() - start) / 1000;
        }
      }
    }).start();
  }
  
  /**
   * Helper to the open method. If an opened cell is empty (not a mine,
   * no number value), it will open neighboring cells to N, S, E, and W.
   * If one of those cells is empty as well, they will in turn open 
   * their neighbors.
   * If one of those cells is a mine, the cell will not be opened.
   * If one of those cells is already opened, the cell will not open its neighbors.
   *
   * @param x   the x position of the opened cell
   * @param y   the y position of the opened cell
   */
  private void openNeighbors(int x, int y) {
    Cell c;
    try {
      c = this.cells[x][y];
    } catch (IndexOutOfBoundsException e) {
      // do nothing, cell outside of bounds
      return;
    } 
    if (c == null || c.getValue() == Cell.MINE) {
      return;
    }
    //System.out.println("(" + x + ", " + y + ")");
    if (!c.getState().equals(CellState.OPENED)) {
      updateFlags(c);
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
      this.firstMove(c);
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
  /**
   * Helper to the open and flag methods. Checks if the game is over and throws
   * an exception if so.
   *
   * @throws IllegalStateException if the game is over
   */
  private void checkGameOver() throws IllegalStateException {
    if (this.isGameOver()) {
      throw new IllegalStateException("Game is over.");
    }
  }
  
  /**
   * Helper to the open and flag methods. If the given cell's state is flagged,
   * increases the flag count by 1;
   *
   * @param c   the cell to be checked
   */
  private void updateFlags(Cell c) {
    if (c.getState().equals(CellState.FLAGGED)) {
      flags += 1;
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
          this.state = GameState.LOSE;
          return true;
        }
        mines += 1;
      } else if (c.getState().equals(CellState.OPENED)) {
        openedCells += 1;
      }
    }
    if (allCells.size() - mines == openedCells) {
      this.state = GameState.WIN;
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
          cellsList.add(new Cell(cells[x][y]));
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
  
  @Override
  public int getTime() {
    return this.timer;
  }
  
  @Override
  public GameState getState() {
    return this.state;
  }
  
  @Override
  public void setGameState(GameState state) throws IllegalArgumentException {
    if (state == null) {
      throw new IllegalArgumentException("Given state is uninitialized.");
    }
    if (!this.isGameOver()) {
      this.state = state;
    }
  }
}