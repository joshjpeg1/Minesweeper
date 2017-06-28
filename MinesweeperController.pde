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
  private int headerSize;
  
  /**
   * Constructs a new {@code MinesweeperController}.
   */
  public MinesweeperController() {
    this.headerSize = height - width;
    this.menu = new MinesweeperMenu(this.headerSize);
  }
  
  /**
   * If the menu is on, this will display the menu.
   * If the menu is off, this will display the current state
   * of the game.
   * If the game is over, this will wait 2 seconds before changing
   * back to the menu screen.
   */
  public void display() {
    if (menuOn) {
      this.menu.display(false);
    } else {
      this.view.display();
      if (this.restart) {
        try {
          Thread.sleep(2000);
          this.mousePress = false;
          this.menuOn = true;
          this.restart = false;
          this.model = null;
          this.view = null;
          this.menu = new MinesweeperMenu(200);
        } catch (InterruptedException e) {
          System.exit(0);
        }
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
   * <p>
   * However, if the menu is on, it will use the mouse handler in the menu
   * to deal with mouse presses.
   */
  public void mouseHandler() {
    if (!this.mousePress && mousePressed) {
      if (menuOn) {
        this.model = this.menu.mouseHandler(mouseX, mouseY);
      } else {
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
          // game is over
        }
        this.model.setGameState(GameState.MOUSEPRESSED);
      }
      this.mousePress = true;
    } else if (this.mousePress && !mousePressed) {
      if (menuOn) {
        if (this.model != null) {
          this.menuOn = false;
          this.view = new MinesweeperView(this.model, headerSize);
          this.model.play();
        }
      } else {
        this.model.setGameState(GameState.PLAYING);
      } 
      this.mousePress = false;
    }
  }
}