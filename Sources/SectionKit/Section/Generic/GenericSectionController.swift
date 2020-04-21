import UIKit

/// A `SectionController` that handles a list of items.
open class GenericSectionController<Item>:
    BaseSectionController,
    GenericSectionControllerProtocol
    where Item: CollectionViewCellRepresentable
{
    // MARK: - GenericSection
    
    /**
     The list of items currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, use `items` instead.
     */
    open var collectionViewItems: [Item] = []
    
    open var items: [Item] {
        get { collectionViewItems }
        set {
            guard let context = context else {
                collectionViewItems = newValue
                return
            }
            let sectionUpdate = calculateUpdate(from: collectionViewItems,
                                                to: newValue)
            context.apply(update: sectionUpdate)
        }
    }
    
    open func calculateUpdate(from oldData: [Item],
                              to newData: [Item]) -> SectionUpdate<[Item]> {
        // just reload the entire section
        let reloadBatchOperation = SectionBatchOperation(changes: [.reloadSection],
                                                         data: newData)
        return SectionUpdate(sectionId: id,
                             batchOperations: [reloadBatchOperation],
                             setData: { [weak self] in self?.collectionViewItems = $0 },
                             shouldReloadSection: { $0.changes.count > 100 })
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        items.count
    }
    
    override open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        let cell = context.dequeueReusableCell(Item.CellType.self, for: indexPath.externalRepresentation)
        items[indexPath.internalRepresentation].configure(cell: cell, at: indexPath, in: context)
        return cell
    }
    
    // MARK: - SectionDelegate
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didSelectItem(at: indexPath.externalRepresentation,
                                                              in: context)
    }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return items[indexPath.internalRepresentation].sizeForItem(at: indexPath.externalRepresentation,
                                                                   using: layout,
                                                                   in: context)
    }
}

