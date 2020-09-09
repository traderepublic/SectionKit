import Foundation

/// A batch of changes to the list of items in a section.
public struct CollectionViewSectionBatchOperation<SectionData> {
    /// The changes to perform to the list of items in a section.
    public let changes: Set<CollectionViewSectionChange>

    /// The data of this section after the `changes` have been performed.
    public let data: SectionData

    /**
     A completion handler that gets called after the updates have been applied.

     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public let completion: ((Bool) -> Void)?

    /**
     Initialize an instance of `CollectionViewSectionBatchOperation`.

     - Parameter changes: The changes to perform to the list of items in a section.

     - Parameter data: The data of the section after the `changes` have been performed.

     - Parameter completion: A completion handler that gets called after the updates have been applied.
     The parameter may be `true` if all of the related animations completed successfully
     or `false` if they were interrupted.
     */
    public init(changes: Set<CollectionViewSectionChange>,
                data: SectionData,
                completion: ((Bool) -> Void)? = nil) {
        self.changes = changes
        self.data = data
        self.completion = completion
    }

    /// Indices of items to delete in this batch operation.
    @inlinable
    public var deletes: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case let .deleteItem(at: index):
                return index

            default:
                return nil
            }
        })
    }

    /// Indices of items to insert in this batch operation.
    @inlinable
    public var inserts: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case let .insertItem(at: index):
                return index

            default:
                return nil
            }
        })
    }

    /// Indices of items to move in this batch operation.
    @inlinable
    public var moves: Set<Move> {
        return Set(changes.compactMap { change -> Move? in
            switch change {
            case let .moveItem(at: source, to: target):
                return Move(at: source, to: target)

            default:
                return nil
            }
        })
    }

    /// Indices of items to reload in this batch operation.
    @inlinable
    public var reloads: Set<Int> {
        return Set(changes.compactMap { change -> Int? in
            switch change {
            case let .reloadItem(at: index):
                return index

            default:
                return nil
            }
        })
    }
}
