import UIKit

/// The drop delegate of a section
@available(iOS 11.0, *)
@MainActor
public protocol SectionDropDelegate: AnyObject {
    /**
     Determines if the section allows drops from the given `UIDropSession`.
     
     - Parameter session: The drop session.

     - Parameter context: The context the drop delegate is contained in.
     
     - Returns: If the section allows drops from the given `UIDropSession`.
     */
    func canHandle(drop session: UIDropSession, in context: CollectionViewContext) -> Bool

    /**
     The position of the drop session changed.
     
     - Parameter session: The drop session.
     
     - Parameter indexPath: The current index path where the session would be dropped to.

     - Parameter context: The context the drop delegate is contained in.
     
     - Returns: A proposal if and how the drop should be performed at the given location.
     */
    func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?,
        in context: CollectionViewContext
    ) -> UICollectionViewDropProposal

    /**
     Perform the drop at the given index path.
     
     - Parameter indexPath: The index path were the drag was dropped to.
     
     - Parameter coordinator: The coordinator containing information about the drop.

     - Parameter context: The context the drop delegate is contained in.
     */
    func performDrop(
        at indexPath: SectionIndexPath?,
        with coordinator: UICollectionViewDropCoordinator,
        in context: CollectionViewContext
    )

    /**
     The drop session entered the area of the `UICollectionView`.

     - Parameter session: The drop session.

     - Parameter context: The context the drop delegate is contained in.
     */
    func dropSessionDidEnter(_ session: UIDropSession, in context: CollectionViewContext)

    /**
     The drop session exited the area of the `UICollectionView`.

     - Parameter session: The drop session.

     - Parameter context: The context the drop delegate is contained in.
     */
    func dropSessionDidExit(_ session: UIDropSession, in context: CollectionViewContext)

    /**
     The current drop session ended.

     - Parameter session: The drop session.

     - Parameter context: The context the drop delegate is contained in.
     */
    func dropSessionDidEnd(_ session: UIDropSession, in context: CollectionViewContext)

    /**
     Returns information on how the item at the given index path should be displayed during the drop.
     
     - Parameter indexPath: The index path of the item being dropped.

     - Parameter context: The context the drop delegate is contained in.
     
     - Returns: Information on how the item at the given index path should be displayed during the drop.
     */
    func dropPreviewParametersForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UIDragPreviewParameters?
}

@available(iOS 11.0, *)
extension SectionDropDelegate {
    public func canHandle(drop session: UIDropSession, in context: CollectionViewContext) -> Bool { true }

    public func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?,
        in context: CollectionViewContext
    ) -> UICollectionViewDropProposal {
        UICollectionViewDropProposal(operation: .forbidden)
    }

    public func dropSessionDidEnter(_ session: UIDropSession, in context: CollectionViewContext) { }

    public func dropSessionDidExit(_ session: UIDropSession, in context: CollectionViewContext) { }

    public func dropSessionDidEnd(_ session: UIDropSession, in context: CollectionViewContext) { }

    public func dropPreviewParametersForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UIDragPreviewParameters? { nil }
}
