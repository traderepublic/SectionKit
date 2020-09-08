import Foundation

/// A batch of changes to the list of sections in a `UICollectionView`.
public struct CollectionViewBatchOperation<CollectionViewData> {
    /// The changes to perform to the list of sections in the `UICollectionView`.
    public let changes: Set<CollectionViewChange>

    /// The data of the `UICollectionView` after the `changes` have been performed.
    public let data: CollectionViewData

    /**
     A completion handler that gets called after the updates have been applied.
     
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?

    /**
     Initialize an instance of `CollectionViewBatchOperation`.

     - Parameter changes: The changes to perform to the list of sections in the `UICollectionView`.

     - Parameter data: The data of the `UICollectionView` after the `changes` have been performed.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(changes: Set<CollectionViewChange>,
                data: CollectionViewData,
                completion: ((Bool) -> Void)? = nil) {
        self.changes = changes
        self.data = data
        self.completion = completion
    }
}

extension CollectionViewBatchOperation {
    /// Indices of sections to delete in this batch operation.
    @inlinable
    public var deletes: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .deleteSection(at: let index):
                return index
            default:
                return nil
            }
        })
    }

    /// Indices of sections to insert in this batch operation.
    @inlinable
    public var inserts: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .insertSection(at: let index):
                return index
            default:
                return nil
            }
        })
    }

    /// Indices of sections to move in this batch operation.
    @inlinable
    public var moves: Set<Move> {
        return Set(changes.compactMap { change -> Move? in
            switch change {
            case .moveSection(at: let source, to: let target):
                return Move(at: source, to: target)
            default:
                return nil
            }
        })
    }

    /// Indices of sections to reload in this batch operation.
    @inlinable
    public var reloads: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case .reloadSection(at: let index):
                return index
            default:
                return nil
            }
        })
    }
}
