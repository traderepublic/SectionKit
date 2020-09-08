import Foundation

/// A `SectionAdapter` that calculates the differences for animated changes to sections of the `UICollectionView`.
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListSectionAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionUpdate<[Section]> {
        let difference = newData.map(\.model.sectionId)
            .difference(from: oldData.map(\.model.sectionId))
            .inferringMoves()
        return CollectionUpdate(changes: difference.collectionChanges,
                                data: newData,
                                setData: { [weak self] in self?.collectionViewSections = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}
