import UIKit

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter: UICollectionViewDragDelegate {
    open func collectionView(_ collectionView: UICollectionView,
                             itemsForBeginning session: UIDragSession,
                             at indexPath: IndexPath) -> [UIDragItem] {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return []
        }
        session.localContext = controller(at: indexPath)
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragItems(forBeginning: session, at: sectionIndexPath)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             itemsForAddingTo session: UIDragSession,
                             at indexPath: IndexPath,
                             point: CGPoint) -> [UIDragItem] {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return []
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragItems(forAddingTo: session, at: sectionIndexPath, point: point)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let dragDelegate = dragDelegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dragDelegate.dragPreviewParametersForItem(at: sectionIndexPath)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragSessionWillBegin session: UIDragSession) {
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragSessionDidEnd session: UIDragSession) {
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragSessionAllowsMoveOperation session: UIDragSession) -> Bool {
        return true
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragSessionIsRestrictedToDraggingApplication session: UIDragSession) -> Bool {
        return false
    }
}
