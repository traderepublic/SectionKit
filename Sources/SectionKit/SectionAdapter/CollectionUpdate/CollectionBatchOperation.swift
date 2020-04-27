import Foundation

/// A batch of changes to the `UICollectionView`
public struct CollectionBatchOperation<CollectionData> {
    /// The changes to perform in a batch operation
    public let changes: Set<CollectionChange>
    
    /// The data of this collection after this batch of updates has been performed
    public let data: CollectionData
    
    public init(changes: Set<CollectionChange>,
                data: CollectionData) {
        self.changes = changes
        self.data = data
    }
}

public extension CollectionBatchOperation {
    /// Indizes to delete in this batch operation
    var deletes: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .deleteSection(at: let index):
                return index
            default:
                return nil
            }
        }
        .sorted()
        .reversed()
    }
    
    /// Indizes to insert in this batch operation
    var inserts: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .insertSection(at: let index):
                return index
            default:
                return nil
            }
        }
        .sorted()
    }
    
    /// Indizes to move in this batch operation
    var moves: [(at: Int, to: Int)] {
        return changes.compactMap { change -> (Int, Int)? in
            switch change {
            case .moveSection(at: let source, to: let target):
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
            case .reloadSection(at: let index):
                return index
            default:
                return nil
            }
        }
    }
}
