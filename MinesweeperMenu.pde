import java.util.Map;

/**
 * Represents the main menu for a game of Minesweeper. Contains an instance
 * of a builder class for a model, which will be called on by BuilderVisitors
 * based on areas clicked in the sketch.
 */
public class MinesweeperMenu {
  private final color HIGHLIGHT = color(#FF0D3C);
  private final color GRAY_BG = color(230);
  private final color GRAY_TXT = color(130);
  private final PFont mono = loadFont("mono.vlw");
  
  private final MinesweeperModelBuilder builder;
  private Map<MouseArea, BuilderVisitor> buttons;
  private int top;
  
  /**
   * Constructs a new {@code MinesweeperMenu}. Initializes the mouse areas
   * for buttons on the sketch.
   *
   * @param top   the top of drawing for the sketch
   */
  public MinesweeperMenu(int top) {
    this.buttons = new HashMap<MouseArea, BuilderVisitor>();
    this.top = top;
    this.builder = new MinesweeperModelBuilder();
    this.display(true);
  }
  
  /**
   * Handles mouse events for the menu. If the given mouse position is
   * within a pre-defined area (button), it will call the respective
   * visitor's visit method on this menu's builder. If the visitor is
   * null, it will call and return the builder's build method.
   *
   * @param mX   the current x-position of the mouse
   * @param mY   the current y-position of the mouse
   */
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
  
  /**
   * Displays the menu with currently selected options for the new game, or
   * initializes the mouse areas and visitors if init is true.
   *
   * @param init   if true, initializes mouse areas and visitors; otherwise
   *               displays the menu with currently selected options
   */
  public void display(boolean init) {
    Posn start = new Posn(50, this.top + 30);
    int size = width / 5;
    int padding = size / 3;
    if (!init) {
      background(255);
      textAlign(RIGHT, BOTTOM);
      textFont(mono, 70);
      fill(0);
      text("Minesweeper", width - (start.getX() + padding), 140);
      textSize(30);
      fill(GRAY_TXT);
      text("NEW", width - (start.getX() + padding), 80);
      noStroke();
    }
    start = displayShapes(start, size, padding, init);
    start = displaySize(start, padding, init);
    start = displayStart(start, padding, init);
  }
  
  /**
   * Displays the shape options for the menu. If init is true, will only intialize
   * mouse areas and visitors for the shape buttons.
   *
   * @param start     the starting position for drawing
   * @param size      the size of buttons
   * @param padding   the padding between buttons
   * @param init      if true, initializes mouse areas and visitors; otherwise
   *                  displays the shape button area
   * @return the new starting position for the next area
   */
  public Posn displayShapes(Posn start, int size, int padding, boolean init) {
    int startX = start.getX();
    int startY = start.getY();
    if (!init) {
      fill(GRAY_TXT);
      textFont(mono, 50);
      textAlign(LEFT, BOTTOM);
      text("Shape", startX + padding, startY + 10);
    }
    startY += 20;
    for (int i = 0; i < GridShape.values().length; i++) {
      if (i % 3 == 0 && i > 0) {
        startY += size + padding;
      }
      final GridShape shape = GridShape.values()[i];
      int multiplier = i % 3;
      if (init) {
        buttons.put(new MouseArea(new Posn(startX + (multiplier * size) + ((multiplier + 1) * padding), startY), size, size),
            new BuilderVisitor() {
              public void visit(MinesweeperModelBuilder builder) {
                builder.setShape(shape);
              }
            });
      } else {
        PImage imgShape = loadImage(shape.getFileName());
        int imgPad = 30;
        imgShape.resize(size - imgPad, size - imgPad);
        image(imgShape, startX + (multiplier * size) + ((multiplier + 1) * padding) + (imgPad / 2), startY + (imgPad / 2));
        if (this.builder.getShape().equals(shape)) {
          fill(HIGHLIGHT, 150);
          rect(startX + (multiplier * size) + ((multiplier + 1) * padding), startY, size, size, 10);
        }
      }
    }
    startY += size + (1.5 * padding);
    return new Posn(startX, startY);
  }
  
  /**
   * Displays the size options for the menu. If init is true, will only intialize
   * mouse areas and visitors for the size increase/decrease buttons.
   *
   * @param start     the starting position for drawing
   * @param padding   the padding between buttons
   * @param init      if true, initializes mouse areas and visitors; otherwise
   *                  displays the size area
   * @return the new starting position for the next area
   */
  public Posn displaySize(Posn start, int padding, boolean init) {
    int startX = start.getX();
    int startY = start.getY();
    int sizeWidth = 90;
    int sizeHeight = 60;
    if (!init) {
      fill(GRAY_TXT);
      text("Size", startX + padding, startY + 10);
      fill(GRAY_BG);
      rect(startX + padding, startY + 20, sizeWidth, sizeHeight, 10, 0, 0, 10);
      fill(GRAY_TXT);
      textSize(40);
      textAlign(RIGHT, BOTTOM);
      text(this.builder.getSize(), startX + padding + 70, startY + 72);
      fill(255);
      rect(startX + padding + sizeWidth, startY + 20, 40, sizeHeight / 2);
      rect(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2), 40, sizeHeight / 2);
      fill(140);
      triangle(startX + padding + sizeWidth + 20, startY + 30,
               startX + padding + sizeWidth + 10, startY + 40,
               startX + padding + sizeWidth + 30, startY + 40);
      triangle(startX + padding + sizeWidth + 20, startY + 40 + (sizeHeight / 2),
               startX + padding + sizeWidth + 10, startY + 30 + (sizeHeight / 2),
               startX + padding + sizeWidth + 30, startY + 30 + (sizeHeight / 2));
      fill(GRAY_BG);
      rect(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2) - 2, 40, 4);
    } else {
      buttons.put(new MouseArea(new Posn(startX + padding + sizeWidth, startY + 20), 40, sizeHeight / 2),
          new BuilderVisitor() {
            public void visit(MinesweeperModelBuilder builder) {
              builder.setSize(builder.getSize() + 1);
            }
          });
      buttons.put(new MouseArea(new Posn(startX + padding + sizeWidth, startY + 20 + (sizeHeight / 2)), 40, sizeHeight / 2),
          new BuilderVisitor() {
            public void visit(MinesweeperModelBuilder builder) {
              builder.setSize(builder.getSize() - 1);
            }
          });
    }
    startY += 125;
    return new Posn(startX, startY);
  }
  
  /**
   * Displays the start button for the menu. If init is true, will only intialize the
   * mouse area and visitor for the start button.
   *
   * @param start     the starting position for drawing
   * @param padding   the padding between buttons
   * @param init      if true, initializes mouse area and visitor; otherwise
   *                  displays the start button
   * @return the new starting position for the next area
   */
  public Posn displayStart(Posn start, int padding, boolean init) {
    int startX = start.getX() + padding;
    int startY = start.getY();
    int w = width - (2 * startX);
    if (init) {
      buttons.put(new MouseArea(new Posn(startX, startY), w, 100), null);
    } else {
      fill(GRAY_BG);
      rect(startX, startY, w, 100, 10);
      fill(GRAY_TXT);
      textSize(50);
      textAlign(CENTER, CENTER);
      text("Start", startX + (w / 2), startY + 50);
    }
    return start;
  }
}