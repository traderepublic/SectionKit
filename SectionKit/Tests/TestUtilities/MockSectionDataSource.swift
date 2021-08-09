import SectionKit
import UIKit
import XCTest

internal class MockSectionDataSource: SectionDataSource {
    // MARK: - numberOfItems

    internal typealias NumberOfItemsBlock = (CollectionViewContext) -> Int

    internal lazy var _numberOfItems: NumberOfItemsBlock = { _ in
        XCTFail("not implemented")
        return 0
    }

    internal func numberOfItems(in context: CollectionViewContext) -> Int {
        _numberOfItems(context)
    }

    // MARK: - cellForItem

    internal typealias CellForItemBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionViewCell

    internal lazy var _cellForItem: CellForItemBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
        _cellForItem(indexPath, context)
    }

    // MARK: - headerView

    internal typealias HeaderViewBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionReusableView

    internal lazy var _headerView: HeaderViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionReusableView()
    }

    internal func headerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView {
        _headerView(indexPath, context)
    }

    // MARK: - footerView

    internal typealias FooterViewBlock = (SectionIndexPath, CollectionViewContext) -> UICollectionReusableView

    internal lazy var _footerView: FooterViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionReusableView()
    }

    internal func footerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView {
        _footerView(indexPath, context)
    }

    // MARK: - canMoveItem

    internal typealias CanMoveItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal lazy var _canMoveItem: CanMoveItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func canMoveItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _canMoveItem(indexPath, context)
    }

    // MARK: - moveItem

    internal typealias MoveItemBlock = (SectionIndexPath, SectionIndexPath, CollectionViewContext) -> Void

    internal lazy var _moveItem: MoveItemBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _moveItem(sourceIndexPath, targetIndexPath, context)
    }
}
