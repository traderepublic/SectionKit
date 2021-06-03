import DifferenceKit
import Foundation
import SectionKit

extension Changeset {
    /// Create a `CollectionViewBatchOperation` containing updates to the list of sections in the `UICollectionView`.
    @inlinable
    public var collectionBatchOperation: CollectionViewBatchOperation<Collection> {
        CollectionViewBatchOperation(
            data: data,
            deletes: Set(elementDeleted.map(\.element)),
            inserts: Set(elementInserted.map(\.element)),
            moves: Set(elementMoved.map { Move(at: $0.element, to: $1.element) }),
            reloads: Set(elementUpdated.map(\.element))
        )
    }

    /**
     Create a `CollectionViewSectionBatchOperation` containing the difference to the list of items
     in a section in the `UICollectionView`.
     */
    @inlinable
    public var sectionBatchOperation: CollectionViewSectionBatchOperation<Collection> {
        CollectionViewSectionBatchOperation(
            data: data,
            deletes: Set(elementDeleted.map(\.element)),
            inserts: Set(elementInserted.map(\.element)),
            moves: Set(elementMoved.map { Move(at: $0.element, to: $1.element) }),
            reloads: Set(elementUpdated.map(\.element))
        )
    }
}
