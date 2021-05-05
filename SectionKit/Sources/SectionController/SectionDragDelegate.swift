import UIKit

/// The drag delegate of a section
@available(iOS 11.0, *)
public protocol SectionDragDelegate: AnyObject {
    /**
     Returns the initial list of items to drag.
     
     - Parameter session: The session of the drag.
     
     - Parameter indexPath: The index path of the item to be dragged.
     
     - Returns: The initial list of items to drag.
     */
    func dragItems(
        forBeginning session: UIDragSession,
        at indexPath: SectionIndexPath
    ) -> [UIDragItem]

    /**
     Returns drag items which should be added to an existing drag.
     
     - Parameter session: The session of the drag.
     
     - Parameter indexPath: The index path of the item to be dragged.
     
     - Parameter point: The location inside the `UICollectionView` that the user tapped on.
     
     - Returns: Drag items which should be added to an existing drag.
     */
    func dragItems(
        forAddingTo session: UIDragSession,
        at indexPath: SectionIndexPath,
        point: CGPoint
    ) -> [UIDragItem]

    /**
     The drag session will begin.

     - Parameter session: The session of the drag.
     */
    func dragSessionWillBegin(_ session: UIDragSession)

    /**
     The drag session did end.

     - Parameter session: The session of the drag.
     */
    func dragSessionDidEnd(_ session: UIDragSession)

    /**
     Returns information on how the item at the given index path should be displayed during the drag.
     
     - Parameter indexPath: The index path of the item being dragged.
     
     - Returns: Information on how the item at the given index path should be displayed during the drag.
     */
    func dragPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters?

    /**
     Returns if the drag session supports a move operation.

     - Parameter session: The session of the drag.

     - Returns: If the drag session supports a move operation.
     */
    func dragSessionAllowsMoveOperation(_ session: UIDragSession) -> Bool

    /**
     Returns if the drag session is restricted to remain in the current app.

     - Parameter session: The session of the drag.

     - Returns: If the drag session is restricted to remain in the current app.
     */
    func dragSessionIsRestrictedToDraggingApplication(_ session: UIDragSession) -> Bool
}

@available(iOS 11.0, *)
extension SectionDragDelegate {
    public func dragItems(
        forAddingTo session: UIDragSession,
        at indexPath: SectionIndexPath,
        point: CGPoint
    ) -> [UIDragItem] {
        []
    }

    public func dragSessionWillBegin(_ session: UIDragSession) { }

    public func dragSessionDidEnd(_ session: UIDragSession) { }

    public func dragPreviewParametersForItem(at indexPath: SectionIndexPath) -> UIDragPreviewParameters? { nil }

    public func dragSessionAllowsMoveOperation(_ session: UIDragSession) -> Bool { true }

    public func dragSessionIsRestrictedToDraggingApplication(_ session: UIDragSession) -> Bool { false }
}
