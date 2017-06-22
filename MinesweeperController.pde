public class MinesweeperController {
  private final MinesweeperOperations model;
  private final MinesweeperView view;
  private boolean mousePress = false;
  
  public MinesweeperController(int size, GridShape shape) {
    this.model = new MinesweeperModel();
    this.view = new MinesweeperView(this.model);
    this.model.generate(size, shape);
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
          this.model.flag(position.getX(), position.getY());
        }
      } catch (IllegalArgumentException e) {
        // mouse pressed out of bounds
      } catch (IllegalStateException e) {
        println(e.getMessage());
      }
      this.mousePress = true;
      this.model.setGameState(GameState.MOUSEPRESSED);
    } else if (this.mousePress && !mousePressed) {
      this.mousePress = false;
      this.model.setGameState(GameState.PLAYING);
    }
  }
}