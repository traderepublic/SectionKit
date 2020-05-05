import Foundation

/// A batch of changes to a section in the `UICollectionView`
public struct SectionBatchOperation<SectionData> {
    /// The changes to perform in a batch operation
    public let changes: Set<SectionChange>
    
    /// The data of this section after this batch of updates has been performed
    public let data: SectionData
    
    /**
     Gets called after the updates have been applied.
     
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?
    
    public init(changes: Set<SectionChange>,
                data: SectionData,
                completion: ((Bool) -> Void)? = nil) {
        self.changes = changes
        self.data = data
        self.completion = completion
    }
}

public extension SectionBatchOperation {
    /// Indizes to delete in this batch operation
    @inlinable
    var deletes: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .deleteItem(at: let index):
                return index
            default:
                return nil
            }
        }
    }
    
    /// Indizes to insert in this batch operation
    @inlinable
    var inserts: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .insertItem(at: let index):
                return index
            default:
                return nil
            }
        }
    }
    
    /// Indizes to move in this batch operation
    @inlinable
    var moves: [(at: Int, to: Int)] {
        return changes.compactMap { change -> (Int, Int)? in
            switch change {
            case .moveItem(at: let source, to: let target):
                return (at: source, to: target)
            default:
                return nil
            }
        }
    }
    
    /// Indizes to reload in this batch operation
    @inlinable
    var reloads: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .reloadItem(at: let index):
                return index
            default:
                return nil
            }
        }
    }
}
