import SectionKit
import UIKit

internal class MockSectionDataSource: SectionDataSource {
    // MARK: - numberOfItems

    internal typealias NumberOfItemsBlock = (CollectionViewContext) -> Int

    internal var _numberOfItems: NumberOfItemsBlock = { _ in fatalError("not implemented") }

    internal func numberOfItems(in context: CollectionViewContext) -> Int {
        _numberOfItems(context)
    }

    // MARK: - cellForItem

    internal typealias CellForItemBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionViewCell

    internal var _cellForItem: CellForItemBlock = { _, _ in fatalError("not implemented") }

    internal func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
        _cellForItem(indexPath, context)
    }

    // MARK: - headerView

    internal typealias HeaderViewBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionReusableView

    internal var _headerView: HeaderViewBlock = { _, _ in fatalError("not implemented") }

    internal func headerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView {
        _headerView(indexPath, context)
    }

    // MARK: - footerView

    internal typealias FooterViewBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionReusableView

    internal var _footerView: FooterViewBlock = { _, _ in fatalError("not implemented") }

    internal func footerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView {
        _footerView(indexPath, context)
    }

    // MARK: - canMoveItem

    internal typealias CanMoveItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _canMoveItem: CanMoveItemBlock = { _, _ in fatalError("not implemented") }

    internal func canMoveItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _canMoveItem(indexPath, context)
    }

    // MARK: - moveItem

    internal typealias MoveItemBlock = (SectionIndexPath, SectionIndexPath, CollectionViewContext) -> Void

    internal var _moveItem: MoveItemBlock = { _, _, _ in fatalError("not implemented") }

    internal func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _moveItem(sourceIndexPath, targetIndexPath, context)
    }
}
