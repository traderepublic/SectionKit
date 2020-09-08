import DifferenceKit
import Foundation
import SectionKit

extension Changeset {
    /// Create a `CollectionViewBatchOperation` containing updates to the list of sections in the `UICollectionView`.
    @inlinable
    public var collectionBatchOperation: CollectionViewBatchOperation<Collection> {
        var changes = Set<CollectionViewChange>()
        for deletion in elementDeleted {
            changes.insert(.deleteSection(at: deletion.element))
        }
        for insertion in elementInserted {
            changes.insert(.insertSection(at: insertion.element))
        }
        for reload in elementUpdated {
            changes.insert(.reloadSection(at: reload.element))
        }
        for (source, target) in elementMoved {
            changes.insert(.moveSection(at: source.element, to: target.element))
        }
        return CollectionViewBatchOperation(changes: changes, data: data)
    }

    /**
     Create a `CollectionViewSectionBatchOperation` containing the difference to the list of items
     in a section in the `UICollectionView`.
     */
    @inlinable
    public var sectionBatchOperation: CollectionViewSectionBatchOperation<Collection> {
        var changes = Set<CollectionViewSectionChange>()
        for deletion in elementDeleted {
            changes.insert(.deleteItem(at: deletion.element))
        }
        for insertion in elementInserted {
            changes.insert(.insertItem(at: insertion.element))
        }
        for reload in elementUpdated {
            changes.insert(.reloadItem(at: reload.element))
        }
        for (source, target) in elementMoved {
            changes.insert(.moveItem(at: source.element, to: target.element))
        }
        return CollectionViewSectionBatchOperation(changes: changes, data: data)
    }
}
