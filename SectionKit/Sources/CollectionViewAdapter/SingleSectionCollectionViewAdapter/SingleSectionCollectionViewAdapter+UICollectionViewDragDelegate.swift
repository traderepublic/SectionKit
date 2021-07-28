import UIKit

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter: UICollectionViewDragDelegate {
    open func collectionView(
        _ collectionView: UICollectionView,
        itemsForBeginning session: UIDragSession,
        at indexPath: IndexPath
    ) -> [UIDragItem] {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return []
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragItems(forBeginning: session, at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        itemsForAddingTo session: UIDragSession,
        at indexPath: IndexPath,
        point: CGPoint
    ) -> [UIDragItem] {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return []
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragItems(forAddingTo: session, at: sectionIndexPath, point: point, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dragPreviewParametersForItemAt indexPath: IndexPath
    ) -> UIDragPreviewParameters? {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragPreviewParametersForItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dragSessionWillBegin session: UIDragSession
    ) {
        section?.controller.dragDelegate?.dragSessionWillBegin(session, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dragSessionDidEnd session: UIDragSession
    ) {
        section?.controller.dragDelegate?.dragSessionDidEnd(session, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dragSessionAllowsMoveOperation session: UIDragSession
    ) -> Bool {
        true
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dragSessionIsRestrictedToDraggingApplication session: UIDragSession
    ) -> Bool {
        false
    }
}
