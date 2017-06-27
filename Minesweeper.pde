/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Minesweeper
 * @description  A game of minesweeper.
 * @version      1.0
 */
 
private MinesweeperController controller;

/**
 * Sets up the controller and size of the sketch.
 */
void setup() {
  size(800, 1000);
  this.controller = new MinesweeperController(25, GridShape.STAR);
}

/**
 * Draws the current state of the game.
 */
void draw() {
  this.controller.display();
}

/**
 * Handles a mouse press by delegating to the controller.
 */
void mousePressed() {
  this.controller.mouseHandler();
}

/**
 * Handles a mouse release by delegating to the controller.
 */
void mouseReleased() {
  this.controller.mouseHandler();
}