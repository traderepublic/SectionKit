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

    private var _errorHandler: ErrorHandling?

    /**
     The error handler of this section.

     If no custom error handler is set and self isn't implementing the `ErrorHandling` protocol,
     the default instance calls `assertionFailure` every time an error occurs.
     */
    open var errorHandler: ErrorHandling {
        get { _errorHandler ?? self as? ErrorHandling ?? AssertionFailureErrorHandler() }
        set { _errorHandler = newValue }
    }

    open func didUpdate(model: Any) { }

    // MARK: - SectionDataSource

    open func numberOfItems(in context: CollectionViewContext) -> Int { 0 }

    open func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
        assertionFailure("cellForItem(at:) not implemented")
        return UICollectionViewCell()
    }

    open func headerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        assertionFailure("headerView(at:) not implemented")
        return UICollectionReusableView()
    }

    open func footerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        assertionFailure("footerView(at:) not implemented")
        return UICollectionReusableView()
    }

    open func canMoveItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { false }

    open func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    // MARK: - SectionDataSourcePrefetchingDelegate

    open func prefetchItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) { }

    open func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) { }

    // MARK: - SectionDelegate

    open func shouldHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    open func didHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    open func didUnhighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    open func shouldSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    open func shouldDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    open func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    open func didDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    open func willDisplay(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    open func willDisplay(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    open func willDisplay(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    open func didEndDisplaying(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    open func didEndDisplaying(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    open func didEndDisplaying(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func shouldShowMenuForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { false }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func canPerform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func perform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?, 
        in context: CollectionViewContext
    ) { }

    open func canFocusItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        shouldSelectItem(at: indexPath, in: context)
    }

    @available(iOS 11.0, *)
    open func shouldSpringLoadItem(
        at indexPath: SectionIndexPath,
        with interactionContext: UISpringLoadedInteractionContext,
        in context: CollectionViewContext
    ) -> Bool {
        true
    }

    @available(iOS 13.0, *)
    open func shouldBeginMultipleSelectionInteraction(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    @available(iOS 13.0, *)
    open func didBeginMultipleSelectionInteraction(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    @available(iOS 13.0, *)
    open func contextMenuConfigurationForItem(
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> UIContextMenuConfiguration? {
        nil
    }

    // MARK: - SectionDragDelegate

    @available(iOS 11.0, *)
    open func dragItems(
        forBeginning session: UIDragSession,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> [UIDragItem] {
        []
    }

    @available(iOS 11.0, *)
    open func dragItems(
        forAddingTo session: UIDragSession,
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> [UIDragItem] {
        []
    }

    @available(iOS 11.0, *)
    open func dragSessionWillBegin(_ session: UIDragSession, in context: CollectionViewContext) { }

    @available(iOS 11.0, *)
    open func dragSessionDidEnd(_ session: UIDragSession, in context: CollectionViewContext) { }

    @available(iOS 11.0, *)
    open func dragPreviewParametersForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UIDragPreviewParameters? {
        nil
    }

    @available(iOS 11.0, *)
    open func dragSessionAllowsMoveOperation(
        _ session: UIDragSession,
        in context: CollectionViewContext
    ) -> Bool {
        true
    }

    @available(iOS 11.0, *)
    open func dragSessionIsRestrictedToDraggingApplication(
        _ session: UIDragSession,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    // MARK: - SectionDropDelegate

    @available(iOS 11.0, *)
    open func canHandle(drop session: UIDropSession, in context: CollectionViewContext) -> Bool { true }

    @available(iOS 11.0, *)
    open func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?,
        in context: CollectionViewContext
    ) -> UICollectionViewDropProposal {
        UICollectionViewDropProposal(operation: .forbidden)
    }

    @available(iOS 11.0, *)
    open func performDrop(
        at indexPath: SectionIndexPath?,
        with coordinator: UICollectionViewDropCoordinator,
        in context: CollectionViewContext
    ) { }

    @available(iOS 11.0, *)
    open func dropSessionDidEnter(_ session: UIDropSession, in context: CollectionViewContext) { }

    @available(iOS 11.0, *)
    open func dropSessionDidExit(_ session: UIDropSession, in context: CollectionViewContext) { }

    @available(iOS 11.0, *)
    open func dropSessionDidEnd(_ session: UIDropSession, in context: CollectionViewContext) { }

    @available(iOS 11.0, *)
    open func dropPreviewParametersForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UIDragPreviewParameters? {
        nil
    }

    // MARK: - SectionFlowDelegate

    open func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
    }

    open func inset(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> UIEdgeInsets {
        (layout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    open func minimumLineSpacing(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 10
    }

    open func minimumInteritemSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
    }

    open func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    open func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
