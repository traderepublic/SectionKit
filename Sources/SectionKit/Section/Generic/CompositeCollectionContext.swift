import UIKit

/// A child context which applies an offset to updates according to the item offset of the current section.
open class CompositeSectionCollectionContext: CollectionContext {
    
    // MARK: - Properties
    
    /// The identifier of the composite section.
    public let sectionId: UUID
    
    /// The parent context where updates should be forwarded to.
    public let parentContext: CollectionContext
    
    open var viewController: UIViewController? { parentContext.viewController }
    
    open var collectionView: UICollectionView { parentContext.collectionView }
    
    open var sectionControllers: () -> [SectionController] {
        get { parentContext.sectionControllers }
        set { parentContext.sectionControllers = newValue }
    }
    
    // MARK: - Initializer
    
    public init(sectionId: UUID, parentContext: CollectionContext) {
        self.sectionId = sectionId
        self.parentContext = parentContext
    }
    
    // MARK: - Container sizing and inset
    
    open var containerSize: CGSize { parentContext.containerSize }
    
    open var containerInset: UIEdgeInsets { parentContext.containerInset }
    
    open var adjustedContainerInset: UIEdgeInsets { parentContext.adjustedContainerInset }
    
    open var insetContainerSize: CGSize { parentContext.insetContainerSize }
    
    // MARK: - Apply
    
    private func itemOffset(forSectionControllerWith sectionControllerId: UUID) -> Int? {
        let sectionControllers = self.sectionControllers()
        guard sectionControllers.contains(where: { $0.id == sectionControllerId }) else {
            return nil
        }
        var itemOffset = 0
        for sectionController in sectionControllers {
            if sectionController.id == sectionControllerId { break }
            itemOffset += sectionController.dataSource.numberOfItems
        }
        return itemOffset
    }
    
    open func apply<T>(update: SectionUpdate<T>) {
        guard
            let offset = itemOffset(forSectionControllerWith: update.sectionId)
            else {
                for batchOperation in update.batchOperations {
                    update.setData(batchOperation.data)
                }
                return
        }
        
        let adjustedBatchOperations = update.batchOperations.map { batchOperation -> SectionBatchOperation<T> in
            let adjustedChanges = batchOperation.changes.map { sectionChange -> SectionChange in
                switch sectionChange {
                case .reloadSection:
                    return .reloadSection
                case .deleteItem(at: let at):
                    return .deleteItem(at: at + offset)
                case .insertItem(at: let at):
                    return .insertItem(at: at + offset)
                case .reloadItem(at: let at):
                    return .reloadItem(at: at + offset)
                case .moveItem(at: let at, to: let to):
                    return .moveItem(at: at + offset,
                                     to: to + offset)
                case .custom(let handler):
                    return .custom(handler)
                }
            }
            return SectionBatchOperation(changes: adjustedChanges, data: batchOperation.data)
        }
        let adjustedUpdate = SectionUpdate(sectionId: sectionId,
                                           batchOperations: adjustedBatchOperations,
                                           setData: update.setData,
                                           shouldReloadSection: update.shouldReloadSection)
        parentContext.apply(update: adjustedUpdate)
    }
    
    open func apply<T>(update: CollectionUpdate<T>) {
        parentContext.apply(update: update)
    }
    
    open func dequeueReusableCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type,
                                                              for indexPath: IndexPath) -> Cell  {
        return parentContext.dequeueReusableCell(cellType, for: indexPath)
    }
    
    open func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        return parentContext.dequeueReusableHeaderView(viewType, for: indexPath)
    }
    
    open func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        return parentContext.dequeueReusableFooterView(viewType, for: indexPath)
    }
    
    // MARK: - Sections
    
    open func sectionControllerWithAdjustedIndexPath(for indexPath: IndexPath) -> (SectionController, SectionIndexPath)? {
        return parentContext.sectionControllerWithAdjustedIndexPath(for: indexPath)
    }
}

