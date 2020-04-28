import Foundation

/// A batch of changes to a section in the `UICollectionView`
public struct SectionBatchOperation<SectionData> {
    /// The changes to perform in a batch operation
    public let changes: Set<SectionChange>
    
    /// The data of this section after this batch of updates has been performed
    public let data: SectionData
    
    public init(changes: Set<SectionChange>,
                data: SectionData) {
        self.changes = changes
        self.data = data
    }
}

public extension SectionBatchOperation {
    /// Indizes to delete in this batch operation
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
