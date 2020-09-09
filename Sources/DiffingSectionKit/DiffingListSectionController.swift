import DifferenceKit
import Foundation
import SectionKit

/**
 A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.
 */
open class DiffingListSectionController<Model: SectionModel, Item: Differentiable>: ListSectionController<Model, Item> {
    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> CollectionViewSectionUpdate<[Item]>? {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return CollectionViewSectionUpdate(sectionId: model.sectionId,
                                           batchOperations: changeSet.map(\.sectionBatchOperation),
                                           setData: { [weak self] in self?.collectionViewItems = $0 },
                                           shouldReload: { $0.changes.count > 100 })
    }
}
