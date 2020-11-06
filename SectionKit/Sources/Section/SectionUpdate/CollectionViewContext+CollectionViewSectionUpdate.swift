import Foundation

extension CollectionViewContext {
    /**
     Perform a batch operation on the specified section in the underlying `UICollectionView`.

     - Parameter controller: The controller of the section where changes should be performed.

     - Parameter changes: The changes to perform to the list of items in a section.

     - Parameter data: The data of the section after the `changes` have been performed.

     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.

     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public func performBatchUpdates<SectionData>(
        controller: SectionController,
        changes: Set<CollectionViewSectionChange>,
        data: SectionData,
        setData: @escaping (SectionData) -> Void,
        shouldReload: @escaping (CollectionViewSectionBatchOperation<SectionData>) -> Bool = { _ in false },
        completion: ((Bool) -> Void)? = nil
    ) {
        let update = CollectionViewSectionUpdate(controller: controller,
                                                 changes: changes,
                                                 data: data,
                                                 setData: setData,
                                                 shouldReload: shouldReload,
                                                 completion: completion)
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
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.
     */
    @inlinable
    public func perform<SectionData>(
        controller: SectionController,
        batchOperations: [CollectionViewSectionBatchOperation<SectionData>],
        setData: @escaping (SectionData) -> Void,
        shouldReload: @escaping (CollectionViewSectionBatchOperation<SectionData>) -> Bool = { _ in false }
    ) {
        let update = CollectionViewSectionUpdate(controller: controller,
                                                 batchOperations: batchOperations,
                                                 setData: setData,
                                                 shouldReload: shouldReload)
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
        completion: ((Bool) -> Void)? = nil
    ) {
        let update = CollectionViewSectionUpdate(controller: controller,
                                                 data: data,
                                                 setData: setData,
                                                 completion: completion)
        apply(update: update)
    }
}
