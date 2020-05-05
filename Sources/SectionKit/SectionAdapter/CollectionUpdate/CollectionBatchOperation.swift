import Foundation

/// A batch of changes to the `UICollectionView`
public struct CollectionBatchOperation<CollectionData> {
    /// The changes to perform in a batch operation
    public let changes: Set<CollectionChange>
    
    /// The data of this collection after this batch of updates has been performed
    public let data: CollectionData
    
    /**
     Gets called after the updates have been applied.
     
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?
    
    public init(changes: Set<CollectionChange>,
                data: CollectionData,
                completion: ((Bool) -> Void)? = nil) {
        self.changes = changes
        self.data = data
        self.completion = completion
    }
}

public extension CollectionBatchOperation {
    /// Indizes to delete in this batch operation
    @inlinable
    var deletes: [Int] {
        return changes.compactMap { change -> Int? in
            switch change {
            case .deleteSection(at: let index):
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
            case .insertSection(at: let index):
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
            case .moveSection(at: let source, to: let target):
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
            case .reloadSection(at: let index):
                return index
            default:
                return nil
            }
        }
    }
}
