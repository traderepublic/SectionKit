import Foundation

/**
 A `SectionController` that handles a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.
 */
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListSectionController<
    Model: SectionModel,
    Item: Hashable
>: ListSectionController<Model, Item> {
    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> CollectionViewSectionUpdate<[Item]>? {
        let difference = newData.difference(from: oldData).inferringMoves()
        return CollectionViewSectionUpdate(sectionId: model.sectionId,
                                           changes: difference.sectionChanges,
                                           data: newData,
                                           setData: { [weak self] in self?.collectionViewItems = $0 },
                                           shouldReload: { $0.changes.count > 100 })
    }
}
