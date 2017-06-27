public class MinesweeperMenu {
  private Map<MouseArea, BuilderVisitor> buttons;
  private int headerSize;
  private final PFont mono = loadFont("mono.vlw");
  private final MinesweeperModelBuilder builder;
  private final color BLUE = color(#0D29FF);
  private final color GREEN = color(#009623);
  
  public MinesweeperMenu(int headerSize) {
    this.buttons = new HashMap<MouseArea, BuilderVisitor>();
    this.headerSize = headerSize;
    this.builder = new MinesweeperModelBuilder();
    init();
  }
  
  public MinesweeperOperations mouseHandler(int mX, int mY) {
    for (MouseArea a : buttons.keySet()) {
      if (a.mouseWithinArea(mX, mY)) {
        BuilderVisitor visitor = buttons.get(a);
        if (visitor == null) {
          return builder.build();
        } else {
          visitor.visit(builder);
        }
      }
    }
    return null;
  }
  
  private void init() {
    Posn start = new Posn(50, this.headerSize + 30);
    int size = width / 5;
    int padding = size / 3;
    start = displayShapes(start, size, padding, true);
    start = displaySize(start, padding, true);
    start = displayStart(start, padding, true);
  }
  
  public void display() {
    background(180);
    Posn start = new Posn(50, this.headerSize + 30);
    int size = width / 5;
    int padding = size / 3;
    fill(255);
    textAlign(RIGHT, BOTTOM);
    textFont(mono, 150);
    text("New", width - (start.getX() + padding), 200);
    start = displayShapes(start, size, padding, false);
    start = displaySize(start, padding, false);
    start = displayStart(start, padding, false);
  }
  
  public Posn displayShapes(Posn start, int size, int padding, boolean init) {
    int startX = start.getX();
    int startY = start.getY();
    fill(125);
    textFont(mono, 50);
    textAlign(LEFT, BOTTOM);
    text("Shape", startX + padding, startY + 10);
    startY += 20;
    noStroke();
    for (int i = 0; i < GridShape.values().length; i++) {
      if (i % 3 == 0 && i > 0) {
        startY += size + padding;
      }
      final GridShape shape = GridShape.values()[i];
      int multiplier = i % 3;
      if (init) {
        buttons.put(new MouseArea(new Posn(startX + (multiplier * size) + ((multiplier + 1) * padding), startY), size, size),
            new BuilderVisitor() {
              @Override
              public void visit(MinesweeperModelBuilder builder) {
                builder.setShape(shape);
              }
            });
      } else {
        fill(255);
        if (this.builder.getShape().equals(shape)) {
          fill(GREEN);
        }
        rect(startX + (multiplier * size) + ((multiplier + 1) * padding), startY, size, size);
        PImage imgShape = loadImage(shape.getFileName());
        imgShape.resize(size - 10, size - 10);
        image(imgShape, startX + (multiplier * size) + ((multiplier + 1) * padding) + 5, startY + 5);
      }
    }
    startY += size + (1.5 * padding);
    return new Posn(startX, startY);
  }
  
  public Posn displaySize(Posn start, int padding, boolean init) {
    int startX = start.getX();
    int startY = start.getY();
    fill(125);
    text("Size", startX + padding, startY + 10);
    int sizeWidth = 90;
    int sizeHeight = 60;
    fill(255);
    rect(startX + padding, startY + 20, sizeWidth, sizeHeight);
    if (init) {
      buttons.put(new MouseArea(new Posn(startX + padding + sizeWidth, startY + 20), 40, sizeHeight / 2),
          new BuilderVisitor() {
            @Override
            public void visit(MinesweeperModelBuilder builder) {
              builder.setSize(builder.getSize() + 1);
            }
          });
      buttons.put(new MouseArea(new Posn(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2)), 40, sizeHeight / 2),
          new BuilderVisitor() {
            @Override
            public void visit(MinesweeperModelBuilder builder) {
              builder.setSize(builder.getSize() - 1);
            }
          });
    } else {
      fill(230);
      rect(startX + padding + sizeWidth, startY + 20, 40, sizeHeight / 2);
      rect(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2), 40, sizeHeight / 2);
      fill(150);
      triangle(startX + padding + sizeWidth + 20, startY + 30,
               startX + padding + sizeWidth + 10, startY + 40,
               startX + padding + sizeWidth + 30, startY + 40);
      triangle(startX + padding + sizeWidth + 20, startY + 40 + (sizeHeight / 2),
               startX + padding + sizeWidth + 10, startY + 30 + (sizeHeight / 2),
               startX + padding + sizeWidth + 30, startY + 30 + (sizeHeight / 2));
      rect(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2) - 1, 40, 2);
      
      fill(125);
      textSize(40);
      textAlign(RIGHT, BOTTOM);
      text(this.builder.getSize(), startX + padding + 70, startY + 72);
    }
    startY += 125;
    return new Posn(startX, startY);
  }
  
  public Posn displayStart(Posn start, int padding, boolean init) {
    int startX = start.getX() + padding;
    int startY = start.getY();
    int w = width - (2 * startX);
    if (init) {
      buttons.put(new MouseArea(new Posn(startX, startY), w, 100), null);
    } else {
      fill(BLUE);
      rect(startX, startY, w, 100);
      fill(255);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("Start", startX + (w / 2), startY + 50);
    }
    return start;
  }
  
  /**
   * Displays the menu of the game, allowing the user to select the shape and size
   * of the grid of cells.
   */
  private void displayMenu() {
    /*background(180);
    fill(125);
    
    
    */
  }
}