import UIKit

/// Declares on a type, that this type is representable as a `UICollectionViewCell`.
public protocol CollectionViewCellRepresentable {
    associatedtype CellType: UICollectionViewCell
    
    /**
     Configure the given `cell`.
     
     - Parameter cell: The `UICollectionViewCell` to configure.
     
     - Parameter indexPath: The index path of the supplied `cell`.
     
     - Parameter context: The current context of the section.
     */
    func configure(cell: CellType,
                   at indexPath: SectionIndexPath,
                   in context: CollectionContext)
    
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
    
    /**
     The item at the given index path got selected.
     
     - Parameter indexPath: The index path which got selected.
     
     - Parameter context: The current context of the section.
     */
    func didSelectItem(at indexPath: IndexPath,
                       in context: CollectionContext)
}

