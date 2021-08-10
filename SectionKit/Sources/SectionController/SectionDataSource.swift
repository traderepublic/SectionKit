import UIKit

/// The datasource of a section
public protocol SectionDataSource: AnyObject {
    /**
     Get the number of items in this section.

     - Parameter context: The context the datasource is contained in.

     - Returns: The number of items in this section.
     */
    func numberOfItems(in context: CollectionViewContext) -> Int

    /**
     Get the cell for the given index path.
     
     - Parameter indexPath: The index path of the cell to return.

     - Parameter context: The context the datasource is contained in.
     
     - Returns: The cell for the given index path.
     */
    func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell

    /**
     Get the header view for the given index path.
     
     - Parameter indexPath: The index path of the header view to return.

     - Parameter context: The context the datasource is contained in.
     
     - Returns: The header view for the given index path.
     */
    func headerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView

    /**
     Get the footer view for the given index path.
     
     - Parameter indexPath: The index path of the footer view to return.

     - Parameter context: The context the datasource is contained in.
     
     - Returns: The footer view for the given index path.
     */
    func footerView(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionReusableView

    /**
     Returns if the item at the given index path can be moved.
     
     - Parameter indexPath: The index path of the item that can be moved.

     - Parameter context: The context the datasource is contained in.
     
     - Returns: If the item at the given index path can be moved.
     */
    func canMoveItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    /**
     Move the item at the given index path.
     
     - Parameter sourceIndexPath: The index path of where the move started.
     
     - Parameter targetIndexPath: The index path of where the move ended.

     - Parameter context: The context the datasource is contained in.
     */
    func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath,
        in context: CollectionViewContext
    )
}

extension SectionDataSource {
    public func headerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        context.errorHandler.nonCritical(error: .notImplemented())
        return UICollectionReusableView()
    }

    public func footerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        context.errorHandler.nonCritical(error: .notImplemented())
        return UICollectionReusableView()
    }

    public func canMoveItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    public func moveItem(
        at sourceIndexPath: SectionIndexPath,
        to targetIndexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }
}
