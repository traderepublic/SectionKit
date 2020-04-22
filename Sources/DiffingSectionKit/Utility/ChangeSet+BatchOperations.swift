import Foundation
import SectionKit
import DifferenceKit

public extension Changeset {
    /// Convert this `Changeset` to a `CollectionBatchOperation` containing section updates.
    var collectionBatchOperation: CollectionBatchOperation<Collection> {
        var changes: [CollectionChange] = []
        for deletion in elementDeleted {
            changes.append(.deleteSection(at: deletion.element))
        }
        for insertion in elementInserted {
            changes.append(.insertSection(at: insertion.element))
        }
        for reload in elementUpdated {
            changes.append(.reloadSection(at: reload.element))
        }
        for (source, target) in elementMoved {
            changes.append(.moveSection(at: source.element, to: target.element))
        }
        return CollectionBatchOperation(changes: changes,
                                        data: data)
    }
    
    /// Convert this `Changeset` to a `SectionBatchOperation` containing item updates to a section.
    var sectionBatchOperation: SectionBatchOperation<Collection> {
        var changes: [SectionChange] = []
        for deletion in elementDeleted {
            changes.append(.deleteItem(at: deletion.element))
        }
        for insertion in elementInserted {
            changes.append(.insertItem(at: insertion.element))
        }
        for reload in elementUpdated {
            changes.append(.reloadItem(at: reload.element))
        }
        for (source, target) in elementMoved {
            changes.append(.moveItem(at: source.element, to: target.element))
        }
        return SectionBatchOperation(changes: changes,
                                     data: data)
    }
}

