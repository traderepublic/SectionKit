import DifferenceKit
import Foundation
import SectionKit

/// A `SectionController` that calculates the differences for animated changes to the items in the section.
open class DiffingListSectionController<Model: SectionModel, Item: Differentiable>: ListSectionController<Model, Item> {
    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> SectionUpdate<[Item]>? {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return SectionUpdate(sectionId: model.sectionId,
                             batchOperations: changeSet.map(\.sectionBatchOperation),
                             setData: { [weak self] in self?.collectionViewItems = $0 },
                             shouldReloadSection: { $0.changes.count > 100 })
    }
}
