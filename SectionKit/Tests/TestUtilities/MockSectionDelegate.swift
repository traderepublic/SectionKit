import SectionKit
import UIKit
import XCTest

internal class MockSectionDelegate: SectionDelegate {
    // MARK: - shouldHighlightItem

    internal typealias ShouldHighlightItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _shouldHighlightItem: ShouldHighlightItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _shouldHighlightItem(indexPath, context)
    }

    // MARK: - didHighlightItem

    internal typealias DidHighlightItemBlock = (SectionIndexPath, CollectionViewContext) -> Void

    internal var _didHighlightItem: DidHighlightItemBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func didHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        _didHighlightItem(indexPath, context)
    }

    // MARK: - didUnhighlightItem

    internal typealias DidUnhighlightItemBlock = (SectionIndexPath, CollectionViewContext) -> Void

    internal var _didUnhighlightItem: DidUnhighlightItemBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func didUnhighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        _didUnhighlightItem(indexPath, context)
    }

    // MARK: - shouldSelectItem

    internal typealias ShouldSelectItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _shouldSelectItem: ShouldSelectItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _shouldSelectItem(indexPath, context)
    }

    // MARK: - shouldDeselectItem

    internal typealias ShouldDeselectItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _shouldDeselectItem: ShouldDeselectItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _shouldDeselectItem(indexPath, context)
    }

    // MARK: - didSelectItem

    internal typealias DidSelectItemBlock = (SectionIndexPath, CollectionViewContext) -> Void

    internal var _didSelectItem: DidSelectItemBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        _didSelectItem(indexPath, context)
    }

    // MARK: - didDeselectItem

    internal typealias DidDeselectItemBlock = (SectionIndexPath, CollectionViewContext) -> Void

    internal var _didDeselectItem: DidDeselectItemBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func didDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        _didDeselectItem(indexPath, context)
    }

    // MARK: - willDisplay:cell

    internal typealias WillDisplayCellBlock = (UICollectionViewCell, SectionIndexPath, CollectionViewContext) -> Void

    internal var _willDisplayCell: WillDisplayCellBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func willDisplay(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _willDisplayCell(cell, indexPath, context)
    }

    // MARK: - willDisplay:headerView

    internal typealias WillDisplayHeaderViewBlock = (UICollectionReusableView, SectionIndexPath, CollectionViewContext) -> Void

    internal var _willDisplayHeaderView: WillDisplayHeaderViewBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func willDisplay(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _willDisplayHeaderView(headerView, indexPath, context)
    }

    // MARK: - willDisplay:footerView

    internal typealias WillDisplayFooterViewBlock = (UICollectionReusableView, SectionIndexPath, CollectionViewContext) -> Void

    internal var _willDisplayFooterView: WillDisplayFooterViewBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func willDisplay(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _willDisplayFooterView(footerView, indexPath, context)
    }

    // MARK: - didEndDisplaying:cell

    internal typealias DidEndDisplayingCellBlock = (UICollectionViewCell, SectionIndexPath, CollectionViewContext) -> Void

    internal var _didEndDisplayingCell: DidEndDisplayingCellBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func didEndDisplaying(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _didEndDisplayingCell(cell, indexPath, context)
    }

    // MARK: - didEndDisplaying:headerView

    internal typealias DidEndDisplayingHeaderViewBlock = (UICollectionReusableView, SectionIndexPath, CollectionViewContext) -> Void

    internal var _didEndDisplayingHeaderView: DidEndDisplayingHeaderViewBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func didEndDisplaying(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _didEndDisplayingHeaderView(headerView, indexPath, context)
    }

    // MARK: - didEndDisplaying:footerView

    internal typealias DidEndDisplayingFooterViewBlock = (UICollectionReusableView, SectionIndexPath, CollectionViewContext) -> Void

    internal var _didEndDisplayingFooterView: DidEndDisplayingFooterViewBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func didEndDisplaying(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) {
        _didEndDisplayingFooterView(footerView, indexPath, context)
    }

    // MARK: - shouldShowMenuForItem

    internal typealias ShouldShowMenuForItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _shouldShowMenuForItem: ShouldShowMenuForItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldShowMenuForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _shouldShowMenuForItem(indexPath, context)
    }

    // MARK: - canPerform

    internal typealias CanPerformBlock = (Selector, SectionIndexPath, Any?, CollectionViewContext) -> Bool

    internal var _canPerform: CanPerformBlock = { _, _, _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func canPerform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) -> Bool {
        _canPerform(action, indexPath, sender, context)
    }

    // MARK: - perform

    internal typealias PerformBlock = (Selector, SectionIndexPath, Any?, CollectionViewContext) -> Void

    internal var _perform: PerformBlock = { _, _, _, _ in
        XCTFail("not implemented")
    }

    internal func perform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) {
        _perform(action, indexPath, sender, context)
    }

    // MARK: - canFocusItem

    internal typealias CanFocusItemBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _canFocusItem: CanFocusItemBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func canFocusItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _canFocusItem(indexPath, context)
    }

    // MARK: - shouldSpringLoadItem

    internal typealias ShouldSpringLoadItemBlock = (SectionIndexPath, UISpringLoadedInteractionContext, CollectionViewContext) -> Bool

    internal var _shouldSpringLoadItem: ShouldSpringLoadItemBlock = { _, _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldSpringLoadItem(
        at indexPath: SectionIndexPath,
        with interactionContext: UISpringLoadedInteractionContext,
        in context: CollectionViewContext
    ) -> Bool {
        _shouldSpringLoadItem(indexPath, interactionContext, context)
    }

    // MARK: - shouldBeginMultipleSelectionInteraction

    internal typealias ShouldBeginMultipleSelectionInteractionBlock = (SectionIndexPath, CollectionViewContext) -> Bool

    internal var _shouldBeginMultipleSelectionInteraction: ShouldBeginMultipleSelectionInteractionBlock = { _, _ in
        XCTFail("not implemented")
        return false
    }

    internal func shouldBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool {
        _shouldBeginMultipleSelectionInteraction(indexPath, context)
    }

    // MARK: - didBeginMultipleSelectionInteraction

    internal typealias DidBeginMultipleSelectionInteractionBlock = (SectionIndexPath, CollectionViewContext) -> Void

    internal var _didBeginMultipleSelectionInteraction: DidBeginMultipleSelectionInteractionBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        _didBeginMultipleSelectionInteraction(indexPath, context)
    }

    // MARK: - contextMenuConfigurationForItem

    internal typealias ContextMenuConfigurationForItemBlock = (SectionIndexPath, CGPoint, CollectionViewContext) -> UIContextMenuConfiguration?

    internal var _contextMenuConfigurationForItem: ContextMenuConfigurationForItemBlock = { _, _, _ in
        XCTFail("not implemented")
        return nil
    }

    internal func contextMenuConfigurationForItem(
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> UIContextMenuConfiguration? {
        _contextMenuConfigurationForItem(indexPath, point, context)
    }
}
