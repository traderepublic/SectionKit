import Foundation

/**
 A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.
 */
@MainActor
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListSectionController<
    Model,
    Item: Hashable
>: ListSectionController<Model, Item> {
    /// The threshold to reload the collection view instead of the batch updates
    private let reloadThreshold: Int

    public init(model: Model, reloadThreshold: Int = 100) {
        self.reloadThreshold = reloadThreshold
        super.init(model: model)
    }

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
            setData: { [weak self] in
                guard let self else { return }
                self.collectionViewItems = $0
            },
            shouldReload: { [weak self] in
                guard let self else { return false }
                // For performance reasons, it is recommended to perform a reload instead of separate inserts/deletes when too many batch operations.
                // The default threshold is `100`.
                return $0.count > self.reloadThreshold
            }
        )
    }
}
