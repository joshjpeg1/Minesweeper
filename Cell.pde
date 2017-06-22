/**
 * Represents a single cell on a grid.
 */
public class Cell {
  public static final int MINE = -1;
  private final PFont mono = loadFont("mono-small.vlw");
  private final color ORANGE = color(#DB8F00);
  private final color RED = color(#FF0D3C);
  private final color GREEN = color(#009623);
  private final color BLUE = color(#0D29FF);
  private final color PURPLE = color(#AB0DFF);
  private final color YELLOW = color(#FFF72B);
  private List<Integer> colors;
  private PImage flag;
  private final DrawUtils utils;
  
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
    this.utils = new DrawUtils();
    this.posn = posn;
    this.state = CellState.CLOSED;
    this.value = 0;
    initColors();
  }
  
  public Cell(Cell other) {
    if (other == null) {
      throw new IllegalArgumentException("Given cell is uninitialized.");
    }
    this.utils = new DrawUtils();
    this.posn = other.posn;
    this.state = other.state;
    this.value = other.value;
    initColors();
  }
  
  private void initColors() {
    this.colors = new ArrayList<Integer>();
    this.colors.add(ORANGE);
    this.colors.add(RED);
    this.colors.add(GREEN);
    this.colors.add(BLUE);
    this.colors.add(YELLOW);
    this.colors.add(PURPLE);
    this.flag = loadImage("flag.png");
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
    textAlign(CENTER, BOTTOM);
    textFont(mono, cellSize);
    if (this.state.equals(CellState.OPENED)) {
      shapeMode(CENTER);
      stroke(80);
      fill(180);
      rect(x * cellSize, top + (y * cellSize), cellSize, cellSize);
      if (this.value == MINE) {
        noStroke();
        fill(0);
        ellipse((x + 0.5) * cellSize, top + ((y + 0.5) * cellSize), cellSize / 2, cellSize / 2);
      } else if (this.value > 0)  {
        fill(colors.get(this.value % colors.size()));
        text(Integer.toString(this.value), (x * cellSize) + (cellSize * 0.5), top + ((y + 1) * cellSize));
      }
    } else {
      displayShell(top, cellSize, x, y);
      if (this.state.equals(CellState.FLAGGED)) {
        displayFlag(top, cellSize, x, y);
      } else if (this.state.equals(CellState.QUESTIONED)) {
        fill(0);
        text("?", (x * cellSize) + (cellSize * 0.5), top + ((y + 1) * cellSize));
      }
    }
  }
  
  private void displayShell(int top, int cellSize, int x, int y) {
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
  
  private void displayFlag(int top, int cellSize, int x, int y) {
    fill(0);
    rect((x + 0.25) * cellSize, top + ((y + 0.75) * cellSize), cellSize * 0.5, cellSize * 0.1);
    rect((x + 0.45) * cellSize, top + ((y + 0.25) * cellSize), cellSize * 0.15, cellSize * 0.5);
    fill(RED);
    triangle((x + 0.6) * cellSize, top + ((y + 0.15) * cellSize),
            (x + 0.6) * cellSize, top + ((y + 0.55) * cellSize),
            (x + 0.3) * cellSize, top + ((y + 0.35) * cellSize));
  }
}