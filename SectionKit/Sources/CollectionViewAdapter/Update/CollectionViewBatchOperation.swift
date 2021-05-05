import Foundation

/// A batch of changes to the list of sections of a `UICollectionView`.
public struct CollectionViewBatchOperation<CollectionViewData> {
    /// The data of the `UICollectionView` after the `changes` have been performed.
    public let data: CollectionViewData

    /// Indices of sections to delete in this batch operation.
    public let deletes: Set<Int>

    /// Indices of sections to insert in this batch operation.
    public let inserts: Set<Int>

    /// Indices of sections to move in this batch operation.
    public let moves: Set<Move>

    /// Indices of sections to reload in this batch operation.
    public let reloads: Set<Int>

    /**
     A completion handler that gets called after the updates have been applied.
     
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?

    /**
     Initialize an instance of `CollectionViewBatchOperation`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter deletes: Indices of sections to delete in this batch operation.

     - Parameter inserts: Indices of sections to insert in this batch operation.

     - Parameter moves: Indices of sections to move in this batch operation.

     - Parameter reloads: Indices of sections to reload in this batch operation.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(
        data: CollectionViewData,
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

extension CollectionViewBatchOperation {
    /// The count of changes in this batch operation.
    @inlinable
    public var count: Int {
        deletes.count
            + inserts.count
            + moves.count
            + reloads.count
    }
}
