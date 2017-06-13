/**
 * The main tab for the trivia game.
 *
 * @author       Joshua Pensky
 * @title        Minesweeper
 * @description  A trivia game.
 * @version      1.0
 */
 
void setup() {
  size(600, 700);
  new MinesweeperModel().generate(20, GridShape.CIRCLE);
}

void draw() {
  
}