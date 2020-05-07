import Foundation

/// A `SectionAdapter` that calculates the differences for animated changes to sections of the `UICollectionView`.
@available(iOS 13, *)
open class FoundationDiffingListSectionAdapter: ListSectionAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionUpdate<[Section]> {
        let boxedOldData = oldData.map { HashableBox($0, hashable: \.model) }
        let boxedNewData = newData.map { HashableBox($0, hashable: \.model) }
        let difference = boxedNewData.difference(from: boxedOldData).inferringMoves()
        var changes: Set<CollectionChange> = []
        for change in difference {
            switch change {
            case .insert(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveSection(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertSection(at: offset))
                }
            case .remove(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if associatedWith == nil {
                    changes.insert(.deleteSection(at: offset))
                }
            }
        }
        return CollectionUpdate(changes: changes,
                                data: newData,
                                setData: { [weak self] in self?.collectionViewSections = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}


