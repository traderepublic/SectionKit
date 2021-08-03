import Foundation

/// A set of batch operations that should be performed.
public struct CollectionViewUpdate<CollectionViewData> {
    public typealias BatchOperation = CollectionViewBatchOperation<CollectionViewData>

    /// The batch operations that should be performed in succession.
    public let batchOperations: [BatchOperation]

    /// A handler that gets executed inside a batch operation to set the backing data of the current batch of updates.
    public let setData: (CollectionViewData) -> Void

    /**
     A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.

     - Note: For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.
     */
    public let shouldReload: (CollectionViewBatchOperation<CollectionViewData>) -> Bool

    /**
     Initialise an instance of `CollectionViewUpdate`.

     - Parameter batchOperations: The batch operations that should be performed in succession.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.
     For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.
     */
    public init(
        batchOperations: [BatchOperation],
        setData: @escaping (CollectionViewData) -> Void,
        shouldReload: @escaping (BatchOperation) -> Bool = { _ in false }
    ) {
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReload = shouldReload
    }

    /**
     Initialise an instance of `CollectionViewUpdate` with a single batch operation.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter deletes: Indices of sections to delete.

     - Parameter inserts: Indices of sections to insert.

     - Parameter moves: Indices of sections to move.

     - Parameter reloads: Indices of sections to reload.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.
     For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.

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
        setData: @escaping (CollectionViewData) -> Void,
        shouldReload: @escaping (BatchOperation) -> Bool = { _ in false },
        completion: ((Bool) -> Void)? = nil
    ) {
        let batchOperation = BatchOperation(
            data: data,
            deletes: deletes,
            inserts: inserts,
            moves: moves,
            reloads: reloads,
            completion: completion
        )
        self.init(
            batchOperations: [batchOperation],
            setData: setData,
            shouldReload: shouldReload
        )
    }

    /**
     Initialise an instance of `CollectionViewUpdate` which always reloads the `UICollectionView`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(
        data: CollectionViewData,
        setData: @escaping (CollectionViewData) -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        self.init(
            data: data,
            setData: setData,
            shouldReload: { _ in true },
            completion: completion
        )
    }
}
