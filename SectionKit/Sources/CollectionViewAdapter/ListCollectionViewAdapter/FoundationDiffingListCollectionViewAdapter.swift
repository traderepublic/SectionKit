import Foundation

/**
 A `CollectionViewAdapter` that contains a list of sections. Changes to that list will be checked
 for the difference to the current value and separate inserts/deletes/moves will be performed accordingly.
 */
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListCollectionViewAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionViewUpdate<[Section]> {
        let difference = newData.map(\.id)
            .difference(from: oldData.map(\.id))
            .inferringMoves()
        return CollectionViewUpdate(changes: difference.collectionViewChanges,
                                    data: newData,
                                    setData: { [weak self] in self?.collectionViewSections = $0 },
                                    shouldReload: { $0.changes.count > 100 })
    }
}
