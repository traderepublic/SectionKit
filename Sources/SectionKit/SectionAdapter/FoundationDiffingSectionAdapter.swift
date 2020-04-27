import Foundation

/// A `SectionAdapter` that calculates the differences for animated changes to sections of the `UICollectionView`.
@available(iOS 13, *)
open class FoundationDiffingSectionAdapter: SectionAdapter {
    override open func calculateUpdate(from oldData: [SectionController],
                                       to newData: [SectionController]) -> CollectionUpdate<[SectionController]> {
        let boxedOldData = oldData.map { HashableBox($0, hashable: \.id) }
        let boxedNewData = newData.map { HashableBox($0, hashable: \.id) }
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
                                setData: { [weak self] in self?.collectionViewSectionControllers = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}


