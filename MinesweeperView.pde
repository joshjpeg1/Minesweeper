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
  
  public MinesweeperView(MinesweeperOperations model) {
    this.headerSize = height - width;
    this.model = model;
    this.utils = new DrawUtils();
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
  }
  
  public Posn getCellPositionFromMouse(int mX, int mY) {
    if (mY < this.headerSize) {
      return new Posn(-1, -1);
    }
    return new Posn(mX / this.cellSize, (mY - this.headerSize) / this.cellSize);
  }
  
  public void display() {
    background(100);
    this.displayCells();
    this.displayHeader();
  }
  
  private void displayCells() {
    this.cellSize = width / model.getSize();
    List<Cell> cells = model.getCells();
    for (Cell c : cells) {
      displayCell(c);
    }
  }
  
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
      rect(x * this.cellSize, this.headerSize + (y * this.cellSize), this.cellSize, this.cellSize);
      if (value == Cell.MINE) {
        noStroke();
        fill(0);
        ellipse((x + 0.5) * this.cellSize, this.headerSize + ((y + 0.5) * this.cellSize), this.cellSize / 2, this.cellSize / 2);
      } else if (value > 0)  {
        fill(colors.get(value % colors.size()));
        text(Integer.toString(value), (x * this.cellSize) + (this.cellSize * 0.5), this.headerSize + ((y + 1) * this.cellSize));
      }
    } else {
      displayCellShell(this.headerSize, this.cellSize, x, y);
      if (state.equals(CellState.FLAGGED)) {
        displayCellFlag(this.headerSize, this.cellSize, x, y);
      } else if (state.equals(CellState.QUESTIONED)) {
        fill(0);
        text("?", (x * this.cellSize) + (this.cellSize * 0.5), this.headerSize + ((y + 1) * this.cellSize));
      }
    }
  }
  
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
  
  private void displayCellFlag(int top, int cellSize, int x, int y) {
    fill(0);
    rect((x + 0.25) * cellSize, top + ((y + 0.75) * cellSize), cellSize * 0.5, cellSize * 0.1);
    rect((x + 0.45) * cellSize, top + ((y + 0.25) * cellSize), cellSize * 0.15, cellSize * 0.5);
    fill(RED);
    triangle((x + 0.6) * cellSize, top + ((y + 0.15) * cellSize),
            (x + 0.6) * cellSize, top + ((y + 0.55) * cellSize),
            (x + 0.3) * cellSize, top + ((y + 0.35) * cellSize));
  }
  
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
    text(utils.padNumber(this.model.getTime(), 3), width - 170, (this.headerSize / 2));
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