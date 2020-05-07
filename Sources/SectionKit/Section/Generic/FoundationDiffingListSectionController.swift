import Foundation

/// A `SectionController` that calculates the differences for animated changes to the items in the section.
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListSectionController<Model, Item>: ListSectionController<Model, Item>
    where Item: Hashable
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
        return SectionUpdate(sectionController: self,
                             changes: changes,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 },
                             shouldReloadSection: { $0.changes.count > 100 })
    }
}

