/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Minesweeper
 * @description  A trivia game.
 * @version      1.0
 */
MinesweeperController controller;

void setup() {
  size(800, 1000);
  this.controller = new MinesweeperController(25, GridShape.CIRCLE);
}

void draw() {
  this.controller.display();
}

void mousePressed() {
  this.controller.mouseHandler();
}

void mouseReleased() {
  this.controller.mouseHandler();
}