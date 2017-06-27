import java.util.Map;
import java.util.TreeMap;

/**
 * Represents a view of the Minesweeper game.
 */
public class MinesweeperView {
  private final color ORANGE = color(#DB8F00);
  private final color RED = color(#FF0D3C);
  private final color GREEN = color(#009623);
  private final color BLUE = color(#0D29FF);
  private final color PURPLE = color(#AB0DFF);
  private final color YELLOW = color(#FFF72B);
  private List<Integer> colors;
  
  private final PFont mono = loadFont("mono.vlw");
  private final PFont monoSmall = loadFont("mono-small.vlw");
  
  private final PImage happy = loadImage("happy.png");
  private final PImage sad = loadImage("sad.png");
  private final PImage thinking = loadImage("thinking.png");
  private final PImage nervous = loadImage("nervous.png");
  
  private int headerSize;
  private int cellSize;
  private MinesweeperOperations model;
  private DrawUtils utils;
  
  /**
   * Constructs a new {@code MinesweeperView} that represents
   * the given model.
   */
  public MinesweeperView(MinesweeperOperations model) {
    this.headerSize = height - width;
    this.model = model;
    this.utils = new DrawUtils();
    initColors();
  }
  
  /**
   * Initializes the list of colors.
   */
  private void initColors() {
    this.colors = new ArrayList<Integer>();
    this.colors.add(ORANGE);
    this.colors.add(RED);
    this.colors.add(GREEN);
    this.colors.add(BLUE);
    this.colors.add(YELLOW);
    this.colors.add(PURPLE);
  }
  
  /**
   * Gets the position of the mouse converted to which cell the mouse
   * is currently on. If the mouse is outside the grid, it will return
   * a position out of the bounds of the grid.
   *
   * @param mX   the x-coordinate of the position
   * @param mY   the y-coordinate of the position
   * @return the cell position of the mouse, or an out-of-bounds position
   * if the mouse is not hovering over a cell
   */
  public Posn getMousePosition(int mX, int mY) {
    if (mY < this.headerSize) {
      return new Posn(-1, -1);
    }
    return new Posn(mX / this.cellSize, (mY - this.headerSize) / this.cellSize);
  }
  
  /**
   * Displays the current state of the game as directed by the model.
   */
  public void display() {
    background(100);
    this.displayCells();
    this.displayHeader();
  }
  
  /**
   * Helper to the display method. Displays all cells on the grid as
   * told by the model.
   */
  private void displayCells() {
    this.cellSize = width / model.getSize();
    List<Cell> cells = model.getCells();
    for (Cell c : cells) {
      displayCell(c);
    }
  }
  
  /**
   * Helper to the displayCells method. Displays the given cell on the
   * sketch based on the current state of the cell.
   *
   * @param c   the cell to be displayed
   */
  private void displayCell(Cell c) {
    int x = c.getPosition().getX();
    int y = c.getPosition().getY();
    int value = c.getValue();
    CellState state = c.getState();
    noStroke();
    textAlign(CENTER, BOTTOM);
    textFont(monoSmall, this.cellSize);
    if (state.equals(CellState.OPENED)) {
      shapeMode(CENTER);
      stroke(80);
      fill(180);
      rect(x * this.cellSize, this.headerSize + (y * this.cellSize), 
          this.cellSize, this.cellSize);
      if (value == Cell.MINE) {
        noStroke();
        fill(0);
        ellipse((x + 0.5) * this.cellSize, this.headerSize + ((y + 0.5) * this.cellSize), 
            this.cellSize / 2, this.cellSize / 2);
      } else if (value > 0)  {
        fill(colors.get(value % colors.size()));
        text(Integer.toString(value), (x * this.cellSize) + (this.cellSize * 0.5), 
            this.headerSize + ((y + 1) * this.cellSize));
      }
    } else {
      displayCellShell(this.headerSize, this.cellSize, x, y);
      if (state.equals(CellState.FLAGGED)) {
        displayCellFlag(this.headerSize, this.cellSize, x, y);
      } else if (state.equals(CellState.QUESTIONED)) {
        fill(0);
        text("?", (x * this.cellSize) + (this.cellSize * 0.5), 
            this.headerSize + ((y + 1) * this.cellSize));
      }
    }
  }
  
  /**
   * Helper to the displayCell method. Will display the "shell", or closed
   * state, of the cell at the given position.
   *
   * @param top        the upper bound of the grid
   * @param cellSize   the size of one side of a cell
   * @param x          the x-position of the cell
   * @param y          the y-position of the cell
   */
  private void displayCellShell(int top, int cellSize, int x, int y) {
    fill(220);
    triangle(x * cellSize, top + (y * cellSize),
            (x + 1) * cellSize, top + (y * cellSize),
            (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
    triangle(x * cellSize, top + (y * cellSize),
             x * cellSize, top + ((y + 1) * cellSize),
            (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
    fill(80);
    triangle(x * cellSize, top + ((y + 1) * cellSize),
            (x + 1) * cellSize, top + ((y + 1) * cellSize),
            (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
    triangle((x + 1) * cellSize, top + (y * cellSize),
            (x + 1) * cellSize, top + ((y + 1) * cellSize),
            (x + 0.5) * cellSize, top + ((y + 0.5) * cellSize));
    fill(150);
    shapeMode(CENTER);
    rect((x + 0.15) * cellSize, top + ((y + 0.15) * cellSize), cellSize * 0.7, cellSize * 0.7);
  }
  
  /**
   * Helper to the displayCell method. Will draw and displat the flag on a
   * flagged cell.
   */
  private void displayCellFlag(int top, int cellSize, int x, int y) {
    fill(0);
    rect((x + 0.25) * cellSize, top + ((y + 0.75) * cellSize), cellSize * 0.5, cellSize * 0.1);
    rect((x + 0.45) * cellSize, top + ((y + 0.25) * cellSize), cellSize * 0.15, cellSize * 0.5);
    fill(RED);
    triangle((x + 0.6) * cellSize, top + ((y + 0.15) * cellSize),
            (x + 0.6) * cellSize, top + ((y + 0.55) * cellSize),
            (x + 0.3) * cellSize, top + ((y + 0.35) * cellSize));
  }
  
  /**
   * Displays the header, with information such as the number of flags left, the amount of timer
   * played (in seconds), and the current state of the game (as depicted by emojis).
   */
  private void displayHeader() {
    fill(180);
    rect(0, 0, width, this.headerSize);
    fill(30);
    rect(20, 20, 300, this.headerSize - 40, 5);
    rect(width - 320, 20, 300, this.headerSize - 40, 5);
    fill(RED);
    textAlign(CENTER, CENTER);
    textFont(mono, 150);
    text(utils.padNumber(this.model.getFlags(), 3), 170, (this.headerSize / 2));
    text(utils.padNumber(Math.min(999, this.model.getTime()), 3), width - 170, (this.headerSize / 2));
    fill(YELLOW);
    PImage emoji;
    switch (this.model.getState()) {
      case WIN:
        emoji = happy;
        break;
      case LOSE:
        emoji = sad;
        break;
      case MOUSEPRESSED:
        emoji = nervous;
        break;
      default:
        emoji = thinking;
    }
    image(emoji, 330, ((this.headerSize - happy.height) / 2));
  }
}