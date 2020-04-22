import UIKit

open class CompositeSectionController: BaseSectionController {
    
    // MARK: - Properties
    
    /// A context which applies an offset to item updates and then forwards these adjusted updates to the parent context.
    open var compositeContext: CompositeSectionCollectionContext?
    
    override open var context: CollectionContext? {
        get { compositeContext }
        set {
            if let context = newValue {
                compositeContext = CompositeSectionCollectionContext(sectionId: id, parentContext: context)
            } else {
                compositeContext = nil
            }
        }
    }
    
    /**
     The list of sections currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, use `sectionControllers` instead.
     */
    open var collectionViewSectionControllers: [SectionController] {
        willSet {
            collectionViewSectionControllers.forEach { $0.context = nil }
        }
        didSet {
            collectionViewSectionControllers.forEach { $0.context = context }
        }
    }
    
    /// The list of sections in the composite section.
    open var sectionControllers: [SectionController] {
        get { collectionViewSectionControllers }
        set {
            guard let context = context else {
                collectionViewSectionControllers = newValue
                return
            }
            let sectionUpdate = calculateUpdate(from: collectionViewSectionControllers,
                                                to: newValue)
            context.apply(update: sectionUpdate)
        }
    }
    
    // MARK: - Initializer
    
    public init(sectionControllers: [SectionController]) {
        self.collectionViewSectionControllers = sectionControllers
        super.init()
        sectionControllers.forEach { $0.context = compositeContext }
    }
    
    // MARK: - Helper functions
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the `UICollectionView`
     
     - Parameter newData: The new data that should be displayed in the `UICollectionView`
     
     - Returns: The update that should be performed on the section
     */
    open func calculateUpdate(from oldData: [SectionController],
                              to newData: [SectionController]) -> SectionUpdate<[SectionController]> {
        return SectionUpdate(sectionId: id,
                             changes: [.reloadSection],
                             data: newData,
                             setData: { [weak self] in self?.collectionViewSectionControllers = $0 })
    }
    
    open func sectionControllerWithOffset(forItemAt indexPath: SectionIndexPath) -> (SectionController, SectionIndexPath)? {
        var sectionOffset = 0
        for section in sectionControllers {
            let numberOfItemsInSection = section.dataSource.numberOfItems
            guard numberOfItemsInSection + sectionOffset > indexPath.internalRepresentation else {
                sectionOffset += numberOfItemsInSection
                continue
            }
            let indexInSection = indexPath.internalRepresentation - sectionOffset
            let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath.externalRepresentation,
                                                    internalRepresentation: indexInSection)
            return (section, sectionIndexPath)
        }
        return nil
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        sectionControllers
            .map { $0.dataSource.numberOfItems }
            .reduce(0, +)
    }
    
    override open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        guard let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath) else {
            assertionFailure("There is no section for the specified index")
            return UICollectionViewCell()
        }
        return section.dataSource.cellForItem(at: sectionIndexPath)
    }
    
    override open func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        guard let firstSection = sectionControllers.first else {
            assertionFailure("There is no section for supplying a supplementary view")
            return UICollectionReusableView()
        }
        return firstSection.dataSource.headerView(at: indexPath)
    }
    
    override open func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        guard let lastSection = sectionControllers.last else {
            assertionFailure("There is no section for supplying a supplementary view")
            return UICollectionReusableView()
        }
        return lastSection.dataSource.footerView(at: indexPath)
    }
    
    override public func canMoveItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    override public func moveItem(at sourceIndexPath: SectionIndexPath,
                                  to targetIndexPath: SectionIndexPath) {
    }
    
    // MARK: - SectionDelegate
    
    override open func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return true }
        return delegate.shouldHighlightItem(at: sectionIndexPath)
    }
    
    override open func didHighlightItem(at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didHighlightItem(at: sectionIndexPath)
    }
    
    override open func didUnhighlightItem(at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didUnhighlightItem(at: sectionIndexPath)
    }
    
    override open func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return true }
        return delegate.shouldSelectItem(at: sectionIndexPath)
    }
    
    override open func shouldDeselectItem(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return true }
        return delegate.shouldDeselectItem(at: sectionIndexPath)
    }
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didSelectItem(at: sectionIndexPath)
    }
    
    override open func didDeselectItem(at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didDeselectItem(at: sectionIndexPath)
    }
    
    override open func willDisplay(cell: UICollectionViewCell, at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.willDisplay(cell: cell, at: sectionIndexPath)
    }
    
    override open func willDisplay(supplementaryView: UICollectionReusableView,
                                   for kind: SectionSupplementaryViewKind,
                                   at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.willDisplay(supplementaryView: supplementaryView, for: kind, at: sectionIndexPath)
    }
    
    override open func didEndDisplaying(cell: UICollectionViewCell,
                                        at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didEndDisplaying(cell: cell, at: sectionIndexPath)
    }
    
    override open func didEndDisplaying(supplementaryView: UICollectionReusableView,
                                        for kind: SectionSupplementaryViewKind,
                                        at indexPath: SectionIndexPath) {
        
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didEndDisplaying(supplementaryView: supplementaryView, for: kind, at: sectionIndexPath)
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    override open func shouldShowMenuForItem(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return false }
        return delegate.shouldShowMenuForItem(at: sectionIndexPath)
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    override open func canPerform(action: Selector,
                                  forItemAt indexPath: SectionIndexPath,
                                  withSender sender: Any?) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return false }
        return delegate.canPerform(action: action, forItemAt: sectionIndexPath, withSender: sender)
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    override open func perform(action: Selector,
                               forItemAt indexPath: SectionIndexPath,
                               withSender sender: Any?) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.perform(action: action, forItemAt: sectionIndexPath, withSender: sender)
    }
    
    override open func canFocusItem(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return shouldSelectItem(at: indexPath) }
        return delegate.canFocusItem(at: sectionIndexPath)
    }
    
    @available(iOS 11.0, *)
    override open func shouldSpringLoadItem(at indexPath: SectionIndexPath,
                                            with context: UISpringLoadedInteractionContext) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return true }
        return delegate.shouldSpringLoadItem(at: sectionIndexPath, with: context)
    }
    
    @available(iOS 13.0, *)
    override open func shouldBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) -> Bool {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return false }
        return delegate.shouldBeginMultipleSelectionInteraction(at: sectionIndexPath)
    }
    
    @available(iOS 13.0, *)
    override open func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return }
        delegate.didBeginMultipleSelectionInteraction(at: sectionIndexPath)
    }
    
    @available(iOS 13.0, *)
    override open func contextMenuConfigurationForItem(at indexPath: SectionIndexPath,
                                                       point: CGPoint) -> UIContextMenuConfiguration? {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let delegate = section.delegate
            else { return nil }
        return delegate.contextMenuConfigurationForItem(at: sectionIndexPath, point: point)
    }
    
    // MARK: - SectionDragDelegate
    
    @available(iOS 11.0, *)
    override open func dragItems(forBeginning session: UIDragSession,
                                 at indexPath: SectionIndexPath) -> [UIDragItem] {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let dragDelegate = section.dragDelegate
            else { return [] }
        return dragDelegate.dragItems(forBeginning: session, at: sectionIndexPath)
    }
    
    @available(iOS 11.0, *)
    override open func dragItems(forAddingTo session: UIDragSession,
                                 at indexPath: SectionIndexPath,
                                 point: CGPoint) -> [UIDragItem] {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let dragDelegate = section.dragDelegate
            else { return [] }
        return dragDelegate.dragItems(forAddingTo: session, at: sectionIndexPath, point: point)
    }
    
    @available(iOS 11.0, *)
    override open func dragPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let dragDelegate = section.dragDelegate
            else { return nil }
        return dragDelegate.dragPreviewParametersForItem(at: sectionIndexPath)
    }
    
    // MARK: - SectionDropDelegate
    
    @available(iOS 11.0, *)
    override public func canHandle(drop session: UIDropSession) -> Bool {
        return false
    }
    
    @available(iOS 11.0, *)
    override public func dropSessionDidUpdate(_ session: UIDropSession,
                                              at indexPath: SectionIndexPath) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .forbidden)
    }
    
    @available(iOS 11.0, *)
    override public func performDrop(at indexPath: SectionIndexPath,
                                     with coordinator: UICollectionViewDropCoordinator) {
    }
    
    @available(iOS 11.0, *)
    override public func dropPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? {
        return nil
    }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        guard
            let (section, sectionIndexPath) = sectionControllerWithOffset(forItemAt: indexPath),
            let flowDelegate = section.flowDelegate
            else { return (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50) }
        return flowDelegate.sizeForItem(at: sectionIndexPath, using: layout)
    }
    
    override open func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        guard let flowDelegate = sectionControllers.first?.flowDelegate else {
            return (layout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
        }
        return flowDelegate.referenceSizeForHeader(using: layout)
    }
    
    override open func referenceSizeForFooter(using layout: UICollectionViewLayout) -> CGSize {
        guard let flowDelegate = sectionControllers.last?.flowDelegate else {
            return (layout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
        }
        return flowDelegate.referenceSizeForFooter(using: layout)
    }
}

