import UIKit

extension SingleSectionCollectionViewAdapter: UICollectionViewDelegate {
    // MARK: - Highlight

    open func collectionView(
        _ collectionView: UICollectionView,
        shouldHighlightItemAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return true
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldHighlightItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didHighlightItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didHighlightItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didUnhighlightItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didUnhighlightItem(at: sectionIndexPath, in: context)
    }

    // MARK: - Selection

    open func collectionView(
        _ collectionView: UICollectionView,
        shouldSelectItemAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return true
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldSelectItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return true
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldDeselectItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didSelectItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didDeselectItem(at: sectionIndexPath, in: context)
    }

    // MARK: - Display

    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.willDisplay(cell: cell, at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        willDisplaySupplementaryView view: UICollectionReusableView,
        forElementKind elementKind: String,
        at indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            delegate.willDisplay(headerView: view, at: sectionIndexPath, in: context)

        case UICollectionView.elementKindSectionFooter:
            delegate.willDisplay(footerView: view, at: sectionIndexPath, in: context)

        default:
            context.errorHandler(error: .unsupportedSupplementaryViewKind(elementKind: elementKind), severity: .warning)
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didEndDisplaying(cell: cell, at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplayingSupplementaryView view: UICollectionReusableView,
        forElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            delegate.didEndDisplaying(headerView: view, at: sectionIndexPath, in: context)

        case UICollectionView.elementKindSectionFooter:
            delegate.didEndDisplaying(footerView: view, at: sectionIndexPath, in: context)

        default:
            context.errorHandler(error: .unsupportedSupplementaryViewKind(elementKind: elementKind), severity: .warning)
        }
    }

    // MARK: - Copy/Paste menu

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(
        _ collectionView: UICollectionView,
        shouldShowMenuForItemAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return false
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldShowMenuForItem(at: sectionIndexPath, in: context)
    }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(
        _ collectionView: UICollectionView,
        canPerformAction action: Selector,
        forItemAt indexPath: IndexPath,
        withSender sender: Any?
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return false
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.canPerform(action: action, forItemAt: sectionIndexPath, withSender: sender, in: context)
    }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(
        _ collectionView: UICollectionView,
        performAction action: Selector,
        forItemAt indexPath: IndexPath,
        withSender sender: Any?
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.perform(action: action, forItemAt: sectionIndexPath, withSender: sender, in: context)
    }

    // MARK: - Custom transition layout

    open func collectionView(
        _ collectionView: UICollectionView,
        transitionLayoutForOldLayout fromLayout: UICollectionViewLayout,
        newLayout toLayout: UICollectionViewLayout
    ) -> UICollectionViewTransitionLayout {
        UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }

    // MARK: - Focus

    open func collectionView(
        _ collectionView: UICollectionView,
        canFocusItemAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return self.collectionView(collectionView, shouldSelectItemAt: indexPath)
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.canFocusItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext
    ) -> Bool {
        true
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
        with coordinator: UIFocusAnimationCoordinator
    ) { }

    open func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? { nil }

    open func collectionView(
        _ collectionView: UICollectionView,
        targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
        toProposedIndexPath proposedIndexPath: IndexPath
    ) -> IndexPath {
        proposedIndexPath
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint
    ) -> CGPoint {
        proposedContentOffset
    }

    // MARK: - Spring Loading

    @available(iOS 11.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        shouldSpringLoadItemAt indexPath: IndexPath,
        with context: UISpringLoadedInteractionContext
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return true
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldSpringLoadItem(at: sectionIndexPath, with: context, in: self.context)
    }

    // MARK: - Multiple Selection

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath
    ) -> Bool {
        guard let delegate = delegate(at: indexPath) else {
            return false
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.shouldBeginMultipleSelectionInteraction(at: sectionIndexPath, in: context)
    }

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        didBeginMultipleSelectionInteractionAt indexPath: IndexPath
    ) {
        guard let delegate = delegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        delegate.didBeginMultipleSelectionInteraction(at: sectionIndexPath, in: context)
    }

    @available(iOS 13.0, *)
    open func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) { }

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let delegate = delegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return delegate.contextMenuConfigurationForItem(at: sectionIndexPath, point: point, in: context)
    }

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        nil
    }

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        nil
    }

    @available(iOS 13.0, *)
    open func collectionView(
        _ collectionView: UICollectionView,
        willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
        animator: UIContextMenuInteractionCommitAnimating
    ) { }
}
