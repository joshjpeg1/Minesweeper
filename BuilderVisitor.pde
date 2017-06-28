/**
 * Represents a visitor for the {@code MinesweeperModelBuilder} that can
 * modify it using its set methods.
 */
public interface BuilderVisitor {
  /**
   * Accepts and visits a builder.
   *
   * @param builder   the builder to be visited
   */
  void visit(MinesweeperModelBuilder builder);
}