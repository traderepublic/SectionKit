import Foundation

/// A batch of changes to a section in the `UICollectionView`
public struct SectionBatchOperation<SectionData> {
    /// The changes to perform in a batch operation
    public let changes: [SectionChange]
    
    /// The data of this section after this batch of updates has been performed
    public let data: SectionData
    
    public init(changes: [SectionChange],
                data: SectionData) {
        self.changes = changes
        self.data = data
    }
}

