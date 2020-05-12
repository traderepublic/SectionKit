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
    /// Indices to delete in this batch operation
    @inlinable
    var deletes: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .deleteItem(at: let index):
                return index
            default:
                return nil
            }
        })
    }
    
    /// Indices to insert in this batch operation
    @inlinable
    var inserts: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .insertItem(at: let index):
                return index
            default:
                return nil
            }
        })
    }
    
    /// Indices to move in this batch operation
    @inlinable
    var moves: Set<Move> {
        return Set(changes.compactMap { change -> Move? in
            switch change {
            case .moveItem(at: let source, to: let target):
                return Move(at: source, to: target)
            default:
                return nil
            }
        })
    }
    
    /// Indices to reload in this batch operation
    @inlinable
    var reloads: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .reloadItem(at: let index):
                return index
            default:
                return nil
            }
        })
    }
}
