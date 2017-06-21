public class MinesweeperController {
  private final MinesweeperOperations model;
  private final MinesweeperView view;
  private boolean mousePress = false;
  
  public MinesweeperController() {
    this.model = new MinesweeperModel();
    this.view = new MinesweeperView(this.model);
    this.model.generate(20, GridShape.RECT);
  }
  
  public void display() {
    this.view.display();
  }
  
  public void mouseHandler() {
    if (!this.mousePress && mousePressed) {
      Posn position = this.view.getMousePosition(mouseX, mouseY);
      try {
        if (mouseButton == LEFT) {
          this.model.open(position.getX(), position.getY());
        } else if (mouseButton == RIGHT) {
          println("FLAG " + position.toString());
        }
      } catch (IllegalArgumentException e) {
        // mouse pressed out of bounds
      }
      this.mousePress = true;
    } else if (this.mousePress && !mousePressed) {
      this.mousePress = false;
    }
  }
}