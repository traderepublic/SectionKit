import Foundation
import SectionKit
import DifferenceKit

public extension Changeset {
    /// Convert this `Changeset` to a `CollectionBatchOperation` containing section updates.
    var collectionBatchOperation: CollectionBatchOperation<Collection> {
        var changes: Set<CollectionChange> = []
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
    
    /// Convert this `Changeset` to a `SectionBatchOperation` containing item updates to a section.
    var sectionBatchOperation: SectionBatchOperation<Collection> {
        var changes: Set<SectionChange> = []
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

