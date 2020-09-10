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

     It is recommended to perform a reload instead of separate inserts/deletes if more than 100 changes
     are applied in a single batch operation.
     */
    public let shouldReload: (CollectionViewBatchOperation<CollectionViewData>) -> Bool

    /**
     Initialize an instance of `CollectionViewUpdate`.

     - Parameter batchOperations: The batch operations that should be performed in succession.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.
     */
    public init(batchOperations: [BatchOperation],
                setData: @escaping (CollectionViewData) -> Void,
                shouldReload: @escaping (BatchOperation) -> Bool = { _ in false }) {
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReload = shouldReload
    }

    /**
     Initialize an instance of `CollectionViewUpdate`.

     - Parameter changes: The changes to perform to the list of sections in a `UICollectionView`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public init(changes: Set<CollectionViewChange>,
                data: CollectionViewData,
                setData: @escaping (CollectionViewData) -> Void,
                shouldReload: @escaping (BatchOperation) -> Bool = { _ in false },
                completion: ((Bool) -> Void)? = nil) {
        let batchOperation = BatchOperation(changes: changes, data: data, completion: completion)
        self.init(batchOperations: [batchOperation],
                  setData: setData,
                  shouldReload: shouldReload)
    }

    /**
     Initialize an instance of `CollectionViewUpdate`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public init(data: CollectionViewData,
                setData: @escaping (CollectionViewData) -> Void,
                completion: ((Bool) -> Void)? = nil) {
        self.init(changes: [],
                  data: data,
                  setData: setData,
                  shouldReload: { _ in true },
                  completion: completion)
    }
}
