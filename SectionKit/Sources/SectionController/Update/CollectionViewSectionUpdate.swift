import Foundation

/// A set of batch operations that should be performed.
public struct CollectionViewSectionUpdate<SectionData> {
    public typealias BatchOperation = CollectionViewSectionBatchOperation<SectionData>

    /// The controller of the section that wants to perform the changes.
    public let controller: SectionController

    /// The batch operations that should be performed in succession.
    public let batchOperations: [BatchOperation]

    /// A handler that gets executed inside a batch operation to set the backing data of the current batch of updates.
    public let setData: @MainActor (SectionData) -> Void

    /**
     A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     
     - Note: For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.
     */
    public let shouldReload: @MainActor (CollectionViewSectionBatchOperation<SectionData>) -> Bool

    /**
     Initialise an instance of `CollectionViewSectionUpdate`.
     
     - Parameter controller: The controller of the section where changes should be performed.
     
     - Parameter batchOperations: The batch operations that should be performed in succession.
     
     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.
     
     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     For performance reasons it is recommended to perform a reload instead of separate inserts/deletes,
     if more than `100` changes are applied in a single batch operation.
     */
    public init(
        controller: SectionController,
        batchOperations: [BatchOperation],
        setData: @escaping @MainActor (SectionData) -> Void,
        shouldReload: @escaping @MainActor (BatchOperation) -> Bool = { _ in false }
    ) {
        self.controller = controller
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReload = shouldReload
    }

    /**
     Initialise an instance of `CollectionViewSectionUpdate` with a single batch operation.
     
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
    public init(
        controller: SectionController,
        data: SectionData,
        deletes: Set<Int> = [],
        inserts: Set<Int> = [],
        moves: Set<Move> = [],
        reloads: Set<Int> = [],
        setData: @escaping @MainActor (SectionData) -> Void,
        shouldReload: @escaping @MainActor (BatchOperation) -> Bool = { _ in false },
        completion: (@MainActor (Bool) -> Void)? = nil
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
            controller: controller,
            batchOperations: [batchOperation],
            setData: setData,
            shouldReload: shouldReload
        )
    }

    /**
     Initialise an instance of `CollectionViewSectionUpdate` which always reloads the `UICollectionView`.
     
     - Parameter controller: The controller of the section where changes should be performed.
     
     - Parameter data: The data of the section after the `changes` have been performed.
     
     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.
     
     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(
        controller: SectionController,
        data: SectionData,
        setData: @escaping @MainActor (SectionData) -> Void,
        completion: (@MainActor (Bool) -> Void)? = nil
    ) {
        self.init(
            controller: controller,
            data: data,
            setData: setData,
            shouldReload: { _ in true },
            completion: completion
        )
    }
}

extension CollectionViewSectionUpdate: Sendable where SectionData: Sendable { }
