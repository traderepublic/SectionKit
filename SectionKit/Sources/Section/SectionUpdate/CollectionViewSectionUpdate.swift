import Foundation

/// A set of batch operations that should be performed.
public struct CollectionViewSectionUpdate<SectionData> {
    public typealias BatchOperation = CollectionViewSectionBatchOperation<SectionData>

    /// The controller of the section that wants to perform the changes.
    public let controller: SectionController

    /// The batch operations that should be performed in succession.
    public let batchOperations: [BatchOperation]

    /// A handler that gets executed inside a batch operation to set the backing data of the current batch of updates.
    public let setData: (SectionData) -> Void

    /**
     A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     
     It is recommended to perform a reload instead of separate inserts/deletes if more than 100 changes
     are applied in a single batch operation.
     */
    public let shouldReload: (CollectionViewSectionBatchOperation<SectionData>) -> Bool

    /**
     Initialize an instance of `CollectionViewSectionUpdate`.
     
     - Parameter controller: The controller of the section where changes should be performed.
     
     - Parameter batchOperations: The batch operations that should be performed in succession.
     
     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.
     
     - Parameter shouldReload: A predicate that determines if instead of applying the given batch operation
     the section should be reloaded.
     It is recommended to perform a reload instead of separate inserts/deletes/moves if more than 100 changes
     are applied in a single batch operation.
     */
    public init(controller: SectionController,
                batchOperations: [BatchOperation],
                setData: @escaping (SectionData) -> Void,
                shouldReload: @escaping (BatchOperation) -> Bool = { _ in false }) {
        self.controller = controller
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReload = shouldReload
    }

    /**
     Initialize an instance of `CollectionViewSectionUpdate`.
     
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
    public init(controller: SectionController,
                changes: Set<CollectionViewSectionChange>,
                data: SectionData,
                setData: @escaping (SectionData) -> Void,
                shouldReload: @escaping (BatchOperation) -> Bool = { _ in false },
                completion: ((Bool) -> Void)? = nil) {
        let batchOperation = BatchOperation(changes: changes, data: data, completion: completion)
        self.init(controller: controller,
                  batchOperations: [batchOperation],
                  setData: setData,
                  shouldReload: shouldReload)
    }

    /**
     Initialize an instance of `CollectionViewSectionUpdate`.
     
     - Parameter controller: The controller of the section where changes should be performed.
     
     - Parameter data: The data of the section after the `changes` have been performed.
     
     - Parameter setData: A handler that gets executed inside a batch operation to set the backing data
     of the current batch of updates.
     
     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    @inlinable
    public init(controller: SectionController,
                data: SectionData,
                setData: @escaping (SectionData) -> Void,
                completion: ((Bool) -> Void)? = nil) {
        self.init(controller: controller,
                  changes: [],
                  data: data,
                  setData: setData,
                  shouldReload: { _ in true },
                  completion: completion)
    }
}
