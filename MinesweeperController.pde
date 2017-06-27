/**
 * Represents a controller of the Minesweeper game.
 */
public class MinesweeperController {
  private MinesweeperOperations model;
  private MinesweeperView view;
  private MinesweeperMenu menu;
  private boolean mousePress = false;
  private boolean menuOn = true;
  private boolean restart = false;
  
  /**
   * Constructs a new {@code MinesweeperController}, given the
   * size and shape of the grid to create.
   *
   * @param size    the size of one side of the grid
   * @param shape   the shape of the grid
   */
  public MinesweeperController(int size, GridShape shape) {
    this.menu = new MinesweeperMenu(200);
  }
  
  /**
   * Displays the current state of the game.
   */
  public void display() {
    if (menuOn) {
      this.menu.display();
    } else {
      this.view.display();
      if (this.restart) {
        int timer = millis();
        while (millis() - timer < 5000);
        this.mousePress = false;
        this.menuOn = true;
        this.restart = false;
        this.model = null;
        this.view = null;
        this.menu = new MinesweeperMenu(200);
      } else if (this.model.isGameOver()) {
        this.restart = true;
      }
    }
  }
  
  /**
   * Handles mouse events passed from the main tab to this controller.
   * If a mouse is pressed, it will change the state of the game to MOUSEPRESSED
   * until the mouse has been released. This prevents the user from being able
   * to open multiple cells at a time.
   * If the left button has been pressed, opens a cell.
   * If the right button has been pressed, flags/questions a cell.
   */
  public void mouseHandler() {
    if (!this.mousePress && mousePressed) {
      if (menuOn) {
        this.model = this.menu.mouseHandler(mouseX, mouseY);
      } else {
        Posn position = this.view.getMousePosition(mouseX, mouseY);
        println(position.toString());
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
        this.model.setGameState(GameState.MOUSEPRESSED);
      }
      this.mousePress = true;
    } else if (this.mousePress && !mousePressed) {
      if (menuOn) {
        if (this.model != null) {
          this.menuOn = false;
          this.view = new MinesweeperView(this.model);
          this.model.play();
        }
      } else {
        this.model.setGameState(GameState.PLAYING);
      } 
      this.mousePress = false;
    }
  }
}