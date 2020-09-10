import Foundation

/// Represents a move from an index to another index.
public struct Move: Hashable {
    /// The index before the move.
    public let at: Int

    /// The index after the move.
    public let to: Int

    /**
     Initialize an instance of `Move`.

     - Parameter at: The index before the move.

     - Parameter to: The index after the move.
     */
    public init(at: Int, to: Int) {
        self.at = at
        self.to = to
    }
}
