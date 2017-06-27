/**
 * Represents an area of the sketch that a mouse can interact with.
 */
public class MouseArea {
  private final int x;
  private final int y;
  private final int w;
  private final int h;

  /**
   * Constructs a new rectangular {@code MouseArea}.
   *
   * @param topLeft    the top-left position of the area
   * @param w          the width of the area
   * @param h          the height of the area
   * @throws IllegalArgumentException if the given position is uninitialized, or if the width
   *                                  or height are negative
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