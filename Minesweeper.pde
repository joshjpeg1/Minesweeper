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
  this.controller = new MinesweeperController(20, GridShape.RECT);
}

void draw() {
  this.controller.display();
}

void mousePressed() {
  controller.mouseHandler();
}

void mouseReleased() {
  controller.mouseHandler();
}