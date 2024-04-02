import Foundation

/**
 A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.
 */
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
@MainActor
open class FoundationDiffingListCompositionalLayoutSectionController<
    Model,
    Item: Hashable
>: ListCompositionalLayoutSectionController<Model, Item> {
    override open func calculateUpdate(
        from oldData: [Item],
        to newData: [Item]
    ) -> CollectionViewSectionUpdate<[Item]>? {
        let changes = newData
            .difference(from: oldData)
            .inferringMoves()
            .changes
        return CollectionViewSectionUpdate(
            controller: self,
            data: newData,
            deletes: changes.deletes,
            inserts: changes.inserts,
            moves: changes.moves,
            reloads: changes.reloads,
            setData: { self.collectionViewItems = $0 },
            shouldReload: { $0.count > 100 }
        )
    }
}
