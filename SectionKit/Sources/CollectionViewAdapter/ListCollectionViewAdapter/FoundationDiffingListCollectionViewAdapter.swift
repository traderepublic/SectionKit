import Foundation

/**
 A `CollectionViewAdapter` that contains a list of sections. Changes to that list will be checked
 for the difference to the current value and separate inserts/deletes/moves will be performed accordingly.
 */
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListCollectionViewAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(
        from oldData: [Section],
        to newData: [Section]
    ) -> CollectionViewUpdate<[Section]> {
        let changes = newData.map(\.id)
            .difference(from: oldData.map(\.id))
            .inferringMoves()
            .changes
        return CollectionViewUpdate(
            data: newData,
            deletes: changes.deletes,
            inserts: changes.inserts,
            moves: changes.moves,
            reloads: changes.reloads,
            setData: { self.collectionViewSections = $0 },
            shouldReload: { $0.count > 100 }
        )
    }
}
