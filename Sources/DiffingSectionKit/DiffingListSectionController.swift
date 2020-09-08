import DifferenceKit
import Foundation
import SectionKit

/// A `ListSectionController` that performs diffing using `DifferenceKit`.
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
