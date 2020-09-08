import Foundation

/// A `CollectionViewAdapter` that calculates the differences of changes to sections in the `UICollectionView`.
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListCollectionViewAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionViewUpdate<[Section]> {
        let difference = newData.map(\.model.sectionId)
            .difference(from: oldData.map(\.model.sectionId))
            .inferringMoves()
        return CollectionViewUpdate(changes: difference.collectionChanges,
                                    data: newData,
                                    setData: { [weak self] in self?.collectionViewSections = $0 },
                                    shouldReloadCollection: { $0.changes.count > 100 })
    }
}
