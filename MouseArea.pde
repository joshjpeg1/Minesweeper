public class MouseArea {
  private final int x;
  private final int y;
  private final int w;
  private final int h;

  /**
   * Constructs a new rectangular mouse area using only the top-left and bottom-right positions.
   *
   * @param topLeft    the top-left position of the area
   * @param botRight   the bottom-right position of the area
   * @throws IllegalArgumentException if the given positions are uninitialized, if the
   *                                  bottom-right bottom's X is less than the top-left's,
   *                                  or if the bottom-right's Y is less than the top-left's.
   */
  protected MouseArea(Posn topLeft, int w, int h)
      throws IllegalArgumentException {
    if (topLeft == null) {
      throw new IllegalArgumentException("Cannot construct area with null positions.");
    } else if (w < 0 || h < 0) {
      throw new IllegalArgumentException("Cannot have negative width/height.");
    }
    this.x = topLeft.getX();
    this.y = topLeft.getY();
    this.w = w;
    this.h = h;
  }

  /**
   * Checks whether or not a mouse is within the given area.
   *
   * @param mX   the x-position of the mouse
   * @param mY   the y-position of the mouse
   * @return true if the mouse cursor is within the area, false otherwise
   */
  protected boolean mouseWithinArea(int mX, int mY) {
    return !(mX < x || mX > x + w || mY < y || mY > y + h);
  }
}