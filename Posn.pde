/**
 * Represents a position on the map.
 */
public final class Posn {
  private int x;
  private int y;
  
  /**
   * Constructs a new {@code Posn} object with the given x and y.
   */
  public Posn(int x, int y) {
    this.x = x;
    this.y = y;
  }
  
  public Posn(Posn other) {
    if (other == null) {
      throw new IllegalArgumentException("Cannot copy uninitialized posn.");
    }
    this.x = other.x;
    this.y = other.y;
  }
  
  @Override
  public boolean equals(Object that) {
    if (this == that) {
      return true;
    } else if (!(that instanceof Posn)) {
      return false;
    }
    Posn other = (Posn) that;
    return this.x == other.x
        && this.y == other.y;
  }
  
  @Override
  public int hashCode() {
    return (this.x * 10000) + this.y;
  }
  
  @Override
  public String toString() {
    return "(" + this.x + ", " + this.y + ")";
  }
  
  public int getX() {
    return this.x;
  }
  
  public int getY() {
    return this.y;
  }
}