import DifferenceKit
import Foundation
import SectionKit

public extension Changeset {
    /// Convert this `Changeset` to a `CollectionViewBatchOperation` containing updates to sections in the `UICollectionView`.
    @inlinable
    var collectionBatchOperation: CollectionViewBatchOperation<Collection> {
        var changes = Set<CollectionChange>()
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
        return CollectionBatchOperation(changes: changes,
                                        data: data)
    }

    /// Convert this `Changeset` to a `CollectionViewSectionBatchOperation` containing item updates to a section.
    @inlinable
    var sectionBatchOperation: CollectionViewSectionBatchOperation<Collection> {
        var changes = Set<SectionChange>()
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
        return SectionBatchOperation(changes: changes,
                                     data: data)
    }
}
