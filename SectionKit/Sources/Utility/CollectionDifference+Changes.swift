import Foundation

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension CollectionDifference {
    /// Create separate sets of deletes, inserts, moves and reloads.
    @inlinable
    public var changes: (deletes: Set<Int>, inserts: Set<Int>, moves: Set<Move>, reloads: Set<Int>) {
        var deletes: Set<Int> = []
        var inserts: Set<Int> = []
        var moves: Set<Move> = []
        for change in self {
            switch change {
            case let .insert(offset: offset, element: _, associatedWith: associatedWith):
                if let associatedWith = associatedWith {
                    moves.insert(Move(at: associatedWith, to: offset))
                } else {
                    inserts.insert(offset)
                }

            case let .remove(offset: offset, element: _, associatedWith: associatedWith):
                if associatedWith == nil {
                    deletes.insert(offset)
                }
            }
        }
        return (deletes: deletes, inserts: inserts, moves: moves, reloads: [])
    }
}
