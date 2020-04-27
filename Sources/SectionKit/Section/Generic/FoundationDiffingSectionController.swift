import Foundation

/// A `SectionController` that calculates the differences for animated changes to the items in the section.
@available(iOS 13, *)
open class FoundationDiffingSectionController<Item>: GenericSectionController<Item>
    where Item: Hashable & CollectionViewCellRepresentable
{
    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> SectionUpdate<[Item]> {
        let difference = newData.difference(from: oldData).inferringMoves()
        var changes: Set<SectionChange> = []
        for change in difference {
            switch change {
            case .insert(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveItem(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertItem(at: offset))
                }
            case .remove(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if associatedWith == nil {
                    changes.insert(.deleteItem(at: offset))
                }
            }
        }
        return SectionUpdate(sectionId: id,
                             changes: changes,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 },
                             shouldReloadSection: { $0.changes.count > 100 })
    }
}

