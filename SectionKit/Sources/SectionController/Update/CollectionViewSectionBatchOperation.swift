import Foundation

/// A batch of changes to the list of items in a section.
public struct CollectionViewSectionBatchOperation<SectionData> {
    /// The data of this section after the `changes` have been performed.
    public let data: SectionData

    /// Indices of items to delete in this batch operation.
    public let deletes: Set<Int>

    /// Indices of items to insert in this batch operation.
    public let inserts: Set<Int>

    /// Indices of items to move in this batch operation.
    public let moves: Set<Move>

    /// Indices of items to reload in this batch operation.
    public let reloads: Set<Int>

    /**
     A completion handler that gets called after the updates have been applied.

     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?

    /**
     Initialize an instance of `CollectionViewSectionBatchOperation`.

     - Parameter data: The data of the section after the `changes` have been performed.

     - Parameter deletes: Indices of items to delete in this batch operation.

     - Parameter inserts: Indices of items to insert in this batch operation.

     - Parameter moves: Indices of items to move in this batch operation.

     - Parameter reloads: Indices of items to reload in this batch operation.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(
        data: SectionData,
        deletes: Set<Int> = [],
        inserts: Set<Int> = [],
        moves: Set<Move> = [],
        reloads: Set<Int> = [],
        completion: ((Bool) -> Void)? = nil
    ) {
        self.data = data
        self.deletes = deletes
        self.inserts = inserts
        self.moves = moves
        self.reloads = reloads
        self.completion = completion
    }
}

extension CollectionViewSectionBatchOperation {
    /// The count of changes in this batch operation.
    @inlinable
    public var count: Int {
        deletes.count
            + inserts.count
            + moves.count
            + reloads.count
    }
}
