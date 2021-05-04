import UIKit

/// The drop delegate of a section
@available(iOS 11.0, *)
public protocol SectionDropDelegate: AnyObject {
    /**
     Determines if the section allows drops from the given `UIDropSession`.
     
     - Parameter session: The drop session.
     
     - Returns: If the section allows drops from the given `UIDropSession`.
     */
    func canHandle(drop session: UIDropSession) -> Bool

    /**
     The position of the drop session changed.
     
     - Parameter session: The drop session.
     
     - Parameter indexPath: The current index path where the session would be dropped to.
     
     - Returns: A proposal if and how the drop should be performed at the given location.
     */
    func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?
    ) -> UICollectionViewDropProposal

    /**
     Perform the drop at the given index path.
     
     - Parameter indexPath: The index path were the drag was dropped to.
     
     - Parameter coordinator: The coordinator containing information about the drop.
     */
    func performDrop(at indexPath: SectionIndexPath?, with coordinator: UICollectionViewDropCoordinator)

    /**
     The drop session entered the area of the `UICollectionView`.

     - Parameter session: The drop session.
     */
    func dropSessionDidEnter(_ session: UIDropSession)

    /**
     The drop session exited the area of the `UICollectionView`.

     - Parameter session: The drop session.
     */
    func dropSessionDidExit(_ session: UIDropSession)

    /**
     The current drop session ended.

     - Parameter session: The drop session.
     */
    func dropSessionDidEnd(_ session: UIDropSession)

    /**
     Returns information on how the item at the given index path should be displayed during the drop.
     
     - Parameter indexPath: The index path of the item being dropped.
     
     - Returns: Information on how the item at the given index path should be displayed during the drop.
     */
    func dropPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters?
}

@available(iOS 11.0, *)
extension SectionDropDelegate {
    public func canHandle(drop session: UIDropSession) -> Bool { true }

    public func dropSessionDidUpdate(
        _ session: UIDropSession,
        at indexPath: SectionIndexPath?
    ) -> UICollectionViewDropProposal { UICollectionViewDropProposal(operation: .forbidden) }

    public func dropSessionDidEnter(_ session: UIDropSession) { }

    public func dropSessionDidExit(_ session: UIDropSession) { }

    public func dropSessionDidEnd(_ session: UIDropSession) { }

    public func dropPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? { nil }
}
