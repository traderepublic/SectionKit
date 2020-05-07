import UIKit

/// The datasource of a section
public protocol SectionDataSource {
    /// The number of items in this section.
    var numberOfItems: Int { get }
    
    /**
     Get the cell for a specified index path.
     
     - Parameter indexPath: The index path of the cell to return.
     
     - Returns: The index of the item for the given index title.
     */
    func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell
    
    /**
     Get the header view for a specified index path.
     
     - Parameter indexPath: The index path of the header view to return.
     
     - Returns: The header view for a specified index path.
     */
    func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView
    
    /**
     Get the footer view for a specified index path.
     
     - Parameter indexPath: The index path of the footer view to return.
     
     - Returns: The footer view for a specified index path.
     */
    func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView
    
    /**
     Returns if the item at the given index path can be moved.
     
     - Parameter indexPath: The index path to check if it can be moved.
     
     - Returns: If the item at the given index path can be moved.
     */
    func canMoveItem(at indexPath: SectionIndexPath) -> Bool
    
    /**
     Move the item at the given index path.
     
     - Parameter sourceIndexPath: The index path of where the move started.
     
     - Parameter targetIndexPath: The index path of where the move ended.
     */
    func moveItem(at sourceIndexPath: SectionIndexPath,
                  to targetIndexPath: SectionIndexPath)
}

public extension SectionDataSource {
    func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("headerView(at:) not implemented")
        return UICollectionReusableView()
    }
    
    func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("footerView(at:) not implemented")
        return UICollectionReusableView()
    }
    
    func canMoveItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    func moveItem(at sourceIndexPath: SectionIndexPath,
                  to targetIndexPath: SectionIndexPath) {
        
    }
}

