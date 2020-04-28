import UIKit

/// A `SectionController` that handles a list of items.
open class ListSectionController<Item>:
    BaseSectionController,
    ListSectionControllerProtocol
    where Item: CollectionViewCellRepresentable
{
    // MARK: - ListSectionControllerProtocol
    
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
        return SectionUpdate(sectionId: id,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 })
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
    
    override open func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return items[indexPath.internalRepresentation].shouldHighlightItem(at: indexPath.externalRepresentation,
                                                                           in: context)
    }
    
    override open func didHighlightItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didHighlightItem(at: indexPath.externalRepresentation,
                                                                 in: context)
    }
    
    override open func didUnhighlightItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didUnhighlightItem(at: indexPath.externalRepresentation,
                                                                   in: context)
    }
    
    override open func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return items[indexPath.internalRepresentation].shouldSelectItem(at: indexPath.externalRepresentation,
                                                                        in: context)
    }
    
    override open func shouldDeselectItem(at indexPath: SectionIndexPath) -> Bool {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return items[indexPath.internalRepresentation].shouldDeselectItem(at: indexPath.externalRepresentation,
                                                                          in: context)
    }
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didSelectItem(at: indexPath.externalRepresentation,
                                                              in: context)
    }
    
    override open func didDeselectItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didDeselectItem(at: indexPath.externalRepresentation,
                                                                in: context)
    }
    
    override open func willDisplay(cell: UICollectionViewCell, at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].willDisplay(cell: cell as! Item.CellType,
                                                            at: indexPath.externalRepresentation,
                                                            in: context)
    }
    
    open override func didEndDisplaying(cell: UICollectionViewCell, at indexPath: SectionIndexPath) {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        items[indexPath.internalRepresentation].didEndDisplaying(cell: cell as! Item.CellType,
                                                                 at: indexPath.externalRepresentation,
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

