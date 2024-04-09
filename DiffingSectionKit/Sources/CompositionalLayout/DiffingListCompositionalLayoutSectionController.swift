import DifferenceKit
import Foundation
import SectionKit

/**
 A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.
 */
@MainActor
@available(iOS 13.0, *)
open class DiffingListCompositionalLayoutSectionController<
    Model,
    Item: Differentiable
>: ListCompositionalLayoutSectionController<Model, Item> {
    override open func calculateUpdate(
        from oldData: [Item],
        to newData: [Item]
    ) -> CollectionViewSectionUpdate<[Item]>? {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return CollectionViewSectionUpdate(
            controller: self,
            batchOperations: changeSet.map(\.sectionBatchOperation),
            setData: { self.collectionViewItems = $0 },
            shouldReload: { $0.count > 100 }
        )
    }
}
