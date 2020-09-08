import Foundation

/// A `SectionController` that calculates the differences for animated changes to the items in the section.
@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
open class FoundationDiffingListSectionController<Model: SectionModel, Item: Hashable>: ListSectionController<Model, Item> {
    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> SectionUpdate<[Item]>? {
        let difference = newData.difference(from: oldData).inferringMoves()
        return SectionUpdate(sectionId: model.sectionId,
                             changes: difference.sectionChanges,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 },
                             shouldReloadSection: { $0.changes.count > 100 })
    }
}
