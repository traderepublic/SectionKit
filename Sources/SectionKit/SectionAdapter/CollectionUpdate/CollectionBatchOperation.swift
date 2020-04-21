import Foundation

/// A batch of changes to the `UICollectionView`
public struct CollectionBatchOperation<CollectionData> {
    /// The changes to perform in a batch operation
    public let changes: [CollectionChange]
    
    /// The data of this collection after this batch of updates has been performed
    public let data: CollectionData
    
    public init(changes: [CollectionChange],
                data: CollectionData) {
        self.changes = changes
        self.data = data
    }
}

