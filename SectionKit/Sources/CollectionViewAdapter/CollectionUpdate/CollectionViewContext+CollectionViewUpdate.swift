import Foundation

extension CollectionViewContext {
    /**
     Perform a batch operation on the underlying `UICollectionView`.

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
    public func performBatchUpdates<CollectionViewData>(
        changes: Set<CollectionViewChange>,
        data: CollectionViewData,
        setData: @escaping (CollectionViewData) -> Void,
        shouldReload: @escaping (CollectionViewBatchOperation<CollectionViewData>) -> Bool = { _ in false },
        completion: ((Bool) -> Void)? = nil
    ) {
        let update = CollectionViewUpdate(changes: changes,
                                          data: data,
                                          setData: setData,
                                          shouldReload: shouldReload,
                                          completion: completion)
        apply(update: update)
    }

    /**
     Perform multiple batch operations on the underlying `UICollectionView`.

     - Parameter batchOperations: The batch operations that should be performed in succession.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the `UICollectionView` should be reloaded.
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.
     */
    @inlinable
    public func perform<CollectionViewData>(
        batchOperations: [CollectionViewBatchOperation<CollectionViewData>],
        setData: @escaping (CollectionViewData) -> Void,
        shouldReload: @escaping (CollectionViewBatchOperation<CollectionViewData>) -> Bool = { _ in false }
    ) {
        let update = CollectionViewUpdate(batchOperations: batchOperations,
                                          setData: setData,
                                          shouldReload: shouldReload)
        apply(update: update)
    }

    /**
     Reload data on the underlying `UICollectionView`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public func reloadData<CollectionViewData>(
        data: CollectionViewData,
        setData: @escaping (CollectionViewData) -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        let update = CollectionViewUpdate(data: data,
                                          setData: setData,
                                          completion: completion)
        apply(update: update)
    }
}
