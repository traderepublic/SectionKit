import Foundation

/// A set of updates that should be performed
public struct CollectionUpdate<CollectionData> {
    /// The batch updates that should be performed
    public let batchOperations: [CollectionBatchOperation<CollectionData>]
    
    /// A closure that gets executed inside a batch operation to set the backing data of the current batch of updates
    public let setData: (CollectionData) -> Void
    
    /**
     A closure that determines if the whole collection should be reloaded instead of performing the batch updates
     
     Its recommended to reload the collection if more than 100 changes are applied in a single batch operation.
     */
    public let shouldReloadCollection: (CollectionBatchOperation<CollectionData>) -> Bool
    
    public init(batchOperations: [CollectionBatchOperation<CollectionData>],
                setData: @escaping (CollectionData) -> Void,
                shouldReloadCollection: @escaping (CollectionBatchOperation<CollectionData>) -> Bool = { _ in false }) {
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReloadCollection = shouldReloadCollection
    }
}

