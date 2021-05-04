import UIKit

/// The datasource of a section
public protocol SectionDataSource: AnyObject {
    /// The number of items in this section.
    var numberOfItems: Int { get }

    /**
     Get the cell for the given index path.
     
     - Parameter indexPath: The index path of the cell to return.
     
     - Returns: The cell for the given index path.
     */
    func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell

    /**
     Get the header view for the given index path.
     
     - Parameter indexPath: The index path of the header view to return.
     
     - Returns: The header view for the given index path.
     */
    func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView

    /**
     Get the footer view for the given index path.
     
     - Parameter indexPath: The index path of the footer view to return.
     
     - Returns: The footer view for the given index path.
     */
    func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView

    /**
     Returns if the item at the given index path can be moved.
     
     - Parameter indexPath: The index path of the item that can be moved.
     
     - Returns: If the item at the given index path can be moved.
     */
    func canMoveItem(at indexPath: SectionIndexPath) -> Bool

    /**
     Move the item at the given index path.
     
     - Parameter sourceIndexPath: The index path of where the move started.
     
     - Parameter targetIndexPath: The index path of where the move ended.
     */
    func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath
    )
}

extension SectionDataSource {
    public func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("headerView(at:) not implemented")
        return UICollectionReusableView()
    }

    public func footerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        assertionFailure("footerView(at:) not implemented")
        return UICollectionReusableView()
    }

    public func canMoveItem(at indexPath: SectionIndexPath) -> Bool { false }

    public func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath
    ) { }
}
