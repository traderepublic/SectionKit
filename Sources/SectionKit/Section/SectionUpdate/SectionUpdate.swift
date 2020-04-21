import Foundation

/// A set of updates that should be performed
public struct SectionUpdate<SectionData> {
    /// The id of the section that wants to perform these changes
    public let sectionId: UUID
    
    /// The batch updates that should be performed
    public let batchOperations: [SectionBatchOperation<SectionData>]
    
    /// A closure that gets executed inside a batch operation to set the backing data of the current batch of updates
    public let setData: (SectionData) -> Void
    
    /**
     A closure that determines if the whole section should be reloaded instead of performing the batch updates
     
     Its recommended to reload the section if more than 100 changes are applied in a single batch operation
     */
    public let shouldReloadSection: (SectionBatchOperation<SectionData>) -> Bool
    
    public init(sectionId: UUID,
                batchOperations: [SectionBatchOperation<SectionData>],
                setData: @escaping (SectionData) -> Void,
                shouldReloadSection: @escaping (SectionBatchOperation<SectionData>) -> Bool = { _ in false }) {
        self.sectionId = sectionId
        self.batchOperations = batchOperations
        self.setData = setData
        self.shouldReloadSection = shouldReloadSection
    }
}

