import UIKit

/**
 A base implementation of all `SectionController` datasource and delegate protocols.
 
 Every declaration is marked `open` and can be overridden.
 */
open class BaseSectionController: SectionController,
                                  SectionDataSource,
                                  SectionDataSourcePrefetchingDelegate,
                                  SectionDelegate,
                                  SectionFlowDelegate,
                                  SectionDragDelegate,
                                  SectionDropDelegate {
    // MARK: - Init

    public init () { }

    // MARK: - SectionController

    open var context: CollectionViewContext?

    open var dataSource: SectionDataSource { self }

    @available(iOS 10.0, *)
    open var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? { self }

    open var delegate: SectionDelegate? { self }

    open var flowDelegate: SectionFlowDelegate? { self }

    @available(iOS 11.0, *)
    open var dragDelegate: SectionDragDelegate? { self }

    @available(iOS 11.0, *)
    open var dropDelegate: SectionDropDelegate? { self }

    open func didUpdate(model: Any) { }

    // MARK: - SectionDataSource

    open var numberOfItems: Int { 0 }

    open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        assertionFailure("cellForItem(at:) not implemented")
        return UICollectionViewCell()
    }

    open func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("headerView(at:) not implemented")
        return UICollectionReusableView()
    }

    open func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("footerView(at:) not implemented")
        return UICollectionReusableView()
    }

    open func canMoveItem(at indexPath: SectionIndexPath) -> Bool { false }

    open func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath
    ) { }

    open var indexTitles: [String]? { nil }

    open func index(for indexTitle: String) -> Int {
        assertionFailure("index(for:) not implemented")
        return 0
    }

    // MARK: - SectionDataSourcePrefetchingDelegate

    open func prefetchItems(at indexPaths: [SectionIndexPath]) { }

    open func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath]) { }

    // MARK: - SectionDelegate

    open func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool { true }

    open func didHighlightItem(at indexPath: SectionIndexPath) { }

    open func didUnhighlightItem(at indexPath: SectionIndexPath) { }

    open func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool { true }

    open func shouldDeselectItem(at indexPath: SectionIndexPath) -> Bool { true }

    open func didSelectItem(at indexPath: SectionIndexPath) { }

    open func didDeselectItem(at indexPath: SectionIndexPath) { }

    open func willDisplay(cell: UICollectionViewCell, at indexPath: SectionIndexPath) { }

    open func willDisplay(headerView: UICollectionReusableView, at indexPath: SectionIndexPath) { }

    open func willDisplay(footerView: UICollectionReusableView, at indexPath: SectionIndexPath) { }

    open func didEndDisplaying(cell: UICollectionViewCell, at indexPath: SectionIndexPath) { }

    open func didEndDisplaying(headerView: UICollectionReusableView, at indexPath: SectionIndexPath) { }

    open func didEndDisplaying(footerView: UICollectionReusableView, at indexPath: SectionIndexPath) { }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func shouldShowMenuForItem(at indexPath: SectionIndexPath) -> Bool { false }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func canPerform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?
    ) -> Bool {
        false
    }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func perform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?
    ) { }

    open func canFocusItem(at indexPath: SectionIndexPath) -> Bool { shouldSelectItem(at: indexPath) }

    @available(iOS 11.0, *)
    open func shouldSpringLoadItem(
        at indexPath: SectionIndexPath,
        with context: UISpringLoadedInteractionContext
    ) -> Bool {
        true
    }

    @available(iOS 13.0, *)
    open func shouldBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) -> Bool { false }

    @available(iOS 13.0, *)
    open func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) { }

    @available(iOS 13.0, *)
    open func contextMenuConfigurationForItem(
        at indexPath: SectionIndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        nil
    }

    // MARK: - SectionDragDelegate

    @available(iOS 11.0, *)
    open func dragItems(forBeginning session: UIDragSession, at indexPath: SectionIndexPath) -> [UIDragItem] { [] }

    @available(iOS 11.0, *)
    open func dragItems(
        forAddingTo session: UIDragSession,
        at indexPath: SectionIndexPath,
        point: CGPoint
    ) -> [UIDragItem] {
        []
    }

    @available(iOS 11.0, *)
    open func dragSessionWillBegin(_ session: UIDragSession) { }

    @available(iOS 11.0, *)
    open func dragSessionDidEnd(_ session: UIDragSession) { }

    @available(iOS 11.0, *)
    open func dragPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? { nil }

    @available(iOS 11.0, *)
    open func dragSessionAllowsMoveOperation(_ session: UIDragSession) -> Bool { true }

    @available(iOS 11.0, *)
    open func dragSessionIsRestrictedToDraggingApplication(_ session: UIDragSession) -> Bool { false }

    // MARK: - SectionDropDelegate

    @available(iOS 11.0, *)
    open func canHandle(drop session: UIDropSession) -> Bool { true }

    @available(iOS 11.0, *)
    open func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?
    ) -> UICollectionViewDropProposal {
        UICollectionViewDropProposal(operation: .forbidden)
    }

    @available(iOS 11.0, *)
    open func performDrop(at indexPath: SectionIndexPath?, with coordinator: UICollectionViewDropCoordinator) { }

    @available(iOS 11.0, *)
    open func dropSessionDidEnter(_ session: UIDropSession) { }

    @available(iOS 11.0, *)
    open func dropSessionDidExit(_ session: UIDropSession) { }

    @available(iOS 11.0, *)
    open func dropSessionDidEnd(_ session: UIDropSession) { }

    @available(iOS 11.0, *)
    open func dropPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? { nil }

    // MARK: - SectionFlowDelegate

    open func sizeForItem(at indexPath: SectionIndexPath, using layout: UICollectionViewLayout) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
    }

    open func inset(using layout: UICollectionViewLayout) -> UIEdgeInsets {
        (layout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    open func minimumLineSpacing(using layout: UICollectionViewLayout) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 10
    }

    open func minimumInteritemSpacing(using layout: UICollectionViewLayout) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
    }

    open func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    open func referenceSizeForFooter(using layout: UICollectionViewLayout) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
