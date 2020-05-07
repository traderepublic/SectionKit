import UIKit

extension ListSectionAdapter: UICollectionViewDelegate {
    
    // MARK: - Highlight
    
    open func collectionView(_ collectionView: UICollectionView,
                             shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return true }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldHighlightItem(at: sectionIndexPath) ?? true
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didHighlightItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didHighlightItem(at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didUnhighlightItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didUnhighlightItem(at: sectionIndexPath)
    }
    
    // MARK: - Selection
    
    open func collectionView(_ collectionView: UICollectionView,
                             shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return true }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldSelectItem(at: sectionIndexPath) ?? true
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return true  }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldDeselectItem(at: sectionIndexPath) ?? true
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didSelectItem(at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didDeselectItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didDeselectItem(at: sectionIndexPath)
    }
    
    // MARK: - Display
    
    open func collectionView(_ collectionView: UICollectionView,
                             willDisplay cell: UICollectionViewCell,
                             forItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.willDisplay(cell: cell,
                                                                     at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             willDisplaySupplementaryView view: UICollectionReusableView,
                             forElementKind elementKind: String,
                             at indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        let delegate = sections[indexPath.section].controller.delegate
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            delegate?.willDisplay(headerView: view,
                                  at: sectionIndexPath)
        case UICollectionView.elementKindSectionFooter:
            delegate?.willDisplay(footerView: view,
                                  at: sectionIndexPath)
        default: break
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didEndDisplaying cell: UICollectionViewCell,
                             forItemAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didEndDisplaying(cell: cell,
                                                                          at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didEndDisplayingSupplementaryView view: UICollectionReusableView,
                             forElementOfKind elementKind: String,
                             at indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        let delegate = sections[indexPath.section].controller.delegate
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            delegate?.didEndDisplaying(headerView: view,
                                       at: sectionIndexPath)
        case UICollectionView.elementKindSectionFooter:
            delegate?.didEndDisplaying(footerView: view,
                                       at: sectionIndexPath)
        default: break
        }
    }
    
    // MARK: - Copy/Paste menu
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(_ collectionView: UICollectionView,
                             shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return false }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldShowMenuForItem(at: sectionIndexPath) ?? false
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(_ collectionView: UICollectionView,
                             canPerformAction action: Selector,
                             forItemAt indexPath: IndexPath,
                             withSender sender: Any?) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return false }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.canPerform(action: action,
                                                                           forItemAt: sectionIndexPath,
                                                                           withSender: sender) ?? false
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    open func collectionView(_ collectionView: UICollectionView,
                             performAction action: Selector,
                             forItemAt indexPath: IndexPath,
                             withSender sender: Any?) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.perform(action: action,
                                                                 forItemAt: sectionIndexPath,
                                                                 withSender: sender)
    }
    
    // MARK: - Custom transition layout
    
    open func collectionView(_ collectionView: UICollectionView,
                             transitionLayoutForOldLayout fromLayout: UICollectionViewLayout,
                             newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout {
        return UICollectionViewTransitionLayout(currentLayout: fromLayout,
                                                nextLayout: toLayout)
    }
    
    // MARK: - Focus
    
    open func collectionView(_ collectionView: UICollectionView,
                             canFocusItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else {
            return self.collectionView(collectionView, shouldSelectItemAt: indexPath)
        }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.canFocusItem(at: sectionIndexPath)
            ?? self.collectionView(collectionView, shouldSelectItemAt: indexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             shouldUpdateFocusIn context: UICollectionViewFocusUpdateContext) -> Bool {
        return true
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             didUpdateFocusIn context: UICollectionViewFocusUpdateContext,
                             with coordinator: UIFocusAnimationCoordinator) {
        
    }
    
    open func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return nil
    }
    
    
    open func collectionView(_ collectionView: UICollectionView,
                             targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath,
                             toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        return proposedIndexPath
    }
    
    
    open func collectionView(_ collectionView: UICollectionView,
                             targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return proposedContentOffset
    }
    
    // MARK: - Spring Loading
    
    @available(iOS 11.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             shouldSpringLoadItemAt indexPath: IndexPath,
                             with context: UISpringLoadedInteractionContext) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return true }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldSpringLoadItem(at: sectionIndexPath,
                                                                                     with: context) ?? true
    }
    
    // MARK: - Multiple Selection
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return false }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.shouldBeginMultipleSelectionInteraction(at: sectionIndexPath) ?? false
    }
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sections[indexPath.section].controller.delegate?.didBeginMultipleSelectionInteraction(at: sectionIndexPath)
    }
    
    @available(iOS 13.0, *)
    open func collectionViewDidEndMultipleSelectionInteraction(_ collectionView: UICollectionView) {
        
    }
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             contextMenuConfigurationForItemAt indexPath: IndexPath,
                             point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPath.section >= 0 && indexPath.section < sections.count else { return nil }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sections[indexPath.section].controller.delegate?.contextMenuConfigurationForItem(at: sectionIndexPath,
                                                                                                point: point)
    }
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return nil
    }
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return nil
    }
    
    @available(iOS 13.0, *)
    open func collectionView(_ collectionView: UICollectionView,
                             willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                             animator: UIContextMenuInteractionCommitAnimating) {
        
    }
}

