import UIKit

/// Declares on a type, that this type is representable as a `UICollectionViewCell`.
public protocol CollectionViewCellRepresentable {
    associatedtype CellType: UICollectionViewCell
    
    // MARK: - Cell configuration
    
    /**
     Configure the given `cell`.
     
     - Parameter cell: The `UICollectionViewCell` to configure.
     
     - Parameter indexPath: The index path of the supplied `cell`.
     
     - Parameter context: The current context of the section.
     */
    func configure(cell: CellType,
                   at indexPath: SectionIndexPath,
                   in context: CollectionContext)
    
    // MARK: - Flow delegate
    
    /**
     Calculate the size of the item at the given index path.
     
     - Parameter indexPath: The index path of the item of which the size should be calculated.
     
     - Parameter layout: The layout in which the size should be calculated.
     
     - Parameter context: The current context of the section.
     
     - Returns: The size of the item at the given index path.
     */
    func sizeForItem(at indexPath: IndexPath,
                     using layout: UICollectionViewLayout,
                     in context: CollectionContext) -> CGSize
    
    // MARK: - Delegate
    
    /**
     Determines if the item should be highlighted during tracking.
     
     - Parameter indexPath: The index path of the cell to be highlighted.
     
     - Parameter context: The current context of the section.
     
     - Returns: If the item should be highlighted during tracking.
     */
    func shouldHighlightItem(at indexPath: IndexPath,
                             in context: CollectionContext) -> Bool
    
    /**
     The item with the given index path was highlighted.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     
     - Parameter context: The current context of the section.
     */
    func didHighlightItem(at indexPath: IndexPath,
                          in context: CollectionContext)
    
    /**
     The item with the given index path was unhighlighted.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     
     - Parameter context: The current context of the section.
     */
    func didUnhighlightItem(at indexPath: IndexPath,
                            in context: CollectionContext)
    
    /**
     Determines if the item should be selected.
     
     - Parameter indexPath: The index path of the cell to be selected.
     
     - Parameter context: The current context of the section.
     
     - Returns: If the item should be selected.
     */
    func shouldSelectItem(at indexPath: IndexPath,
                          in context: CollectionContext) -> Bool
    
    /**
     Determines if the item should be deselected.
     
     - Parameter indexPath: The index path of the cell to be deselected.
     
     - Parameter context: The current context of the section.
     
     - Returns: If the item should be deselected.
     */
    func shouldDeselectItem(at indexPath: IndexPath,
                            in context: CollectionContext) -> Bool
    
    /**
     The item with the given index path was selected.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     
     - Parameter context: The current context of the section.
     */
    func didSelectItem(at indexPath: IndexPath,
                       in context: CollectionContext)
    
    /**
     The item with the given index path was deselected.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     
     - Parameter context: The current context of the section.
     */
    func didDeselectItem(at indexPath: IndexPath,
                         in context: CollectionContext)
    
    /**
     The given cell is about to be displayed.
     
     - Parameter cell: The cell that is about to be displayed.
     
     - Parameter indexPath: The index path of the cell that is about to be displayed.
     
     - Parameter context: The current context of the section.
     */
    func willDisplay(cell: CellType,
                     at indexPath: IndexPath,
                     in context: CollectionContext)
    
    /**
     The given cell was removed from the `UICollectionView`.
     
     - Parameter cell: The cell that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the supplementary view that is about to be displayed.
     
     - Parameter context: The current context of the section.
     */
    func didEndDisplaying(cell: CellType,
                          at indexPath: IndexPath,
                          in context: CollectionContext)
}

extension CollectionViewCellRepresentable {
    func sizeForItem(at indexPath: IndexPath,
                     using layout: UICollectionViewLayout,
                     in context: CollectionContext) -> CGSize {
        return (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
    }
    
    func shouldHighlightItem(at indexPath: IndexPath,
                             in context: CollectionContext) -> Bool {
        return true
    }
    
    func didHighlightItem(at indexPath: IndexPath,
                          in context: CollectionContext) {
        
    }
    
    func didUnhighlightItem(at indexPath: IndexPath,
                            in context: CollectionContext) {
        
    }
    
    func shouldSelectItem(at indexPath: IndexPath,
                          in context: CollectionContext) -> Bool {
        return true
    }
    
    func shouldDeselectItem(at indexPath: IndexPath,
                            in context: CollectionContext) -> Bool {
        return true
    }
    
    func didSelectItem(at indexPath: IndexPath,
                       in context: CollectionContext) {
        
    }
    
    func didDeselectItem(at indexPath: IndexPath,
                         in context: CollectionContext) {
        
    }
    
    func willDisplay(cell: CellType,
                     at indexPath: IndexPath,
                     in context: CollectionContext) {
        
    }
    
    func didEndDisplaying(cell: CellType,
                          at indexPath: IndexPath,
                          in context: CollectionContext) {
        
    }
}
