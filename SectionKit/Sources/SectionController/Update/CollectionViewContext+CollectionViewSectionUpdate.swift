import Foundation

extension CollectionViewContext {
    /**
     Perform a batch operation on the specified section in the underlying `UICollectionView`.

     - Parameter controller: The controller of the section where changes should be performed.

     - Parameter data: The data of the section after the `changes` have been performed.

     - Parameter deletes: Indices of items to delete.

     - Parameter inserts: Indices of items to insert.

     - Parameter moves: Indices of items to move.

     - Parameter reloads: Indices of items to reload.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public func performBatchUpdates<SectionData>(
        controller: SectionController,
        data: SectionData,
        deletes: Set<Int> = [],
        inserts: Set<Int> = [],
        moves: Set<Move> = [],
        reloads: Set<Int> = [],
        setData: @escaping @MainActor (SectionData) -> Void,
        shouldReload: @escaping @MainActor (CollectionViewSectionBatchOperation<SectionData>) -> Bool = { _ in false },
        completion: (@MainActor (Bool) -> Void)? = nil
    ) {
        let update = CollectionViewSectionUpdate(
            controller: controller,
            data: data,
            deletes: deletes,
            inserts: inserts,
            moves: moves,
            reloads: reloads,
            setData: setData,
            shouldReload: shouldReload,
            completion: completion
        )
        apply(update: update)
    }

    /**
     Perform multiple batch operations on the specified section in the underlying `UICollectionView`.

     - Parameter controller: The controller of the section where changes should be performed.

     - Parameter batchOperations: The batch operations that should be performed in succession.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.
     */
    @inlinable
    public func perform<SectionData>(
        controller: SectionController,
        batchOperations: [CollectionViewSectionBatchOperation<SectionData>],
        setData: @escaping @MainActor (SectionData) -> Void,
        shouldReload: @escaping @MainActor (CollectionViewSectionBatchOperation<SectionData>) -> Bool = { _ in false }
    ) {
        let update = CollectionViewSectionUpdate(
            controller: controller,
            batchOperations: batchOperations,
            setData: setData,
            shouldReload: shouldReload
        )
        apply(update: update)
    }

    /**
     Reload the specified section in the underlying `UICollectionView`.

     - Parameter controller: The controller of the section where changes should be performed.

     - Parameter data: The data of the section after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public func reloadSection<SectionData>(
        controller: SectionController,
        data: SectionData,
        setData: @escaping (SectionData) -> Void,
        completion: (@MainActor (Bool) -> Void)? = nil
    ) {
        let update = CollectionViewSectionUpdate(
            controller: controller,
            data: data,
            setData: setData,
            completion: completion
        )
        apply(update: update)
    }
}
