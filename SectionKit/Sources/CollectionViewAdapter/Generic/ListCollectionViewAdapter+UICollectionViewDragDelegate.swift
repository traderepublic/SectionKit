import UIKit

@available(iOS 11.0, *)
extension ListCollectionViewAdapter: UICollectionViewDragDelegate {
    open func collectionView(_ collectionView: UICollectionView,
                             itemsForBeginning session: UIDragSession,
                             at indexPath: IndexPath) -> [UIDragItem] {
        guard
            indexPath.isSectionIndexValid(for: sections),
            let dragDelegate = sections[indexPath.section].controller.dragDelegate
            else { return [] }
        session.localContext = sections[indexPath.section].controller
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        return dragDelegate.dragItems(forBeginning: session, at: sectionIndexPath)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             itemsForAddingTo session: UIDragSession,
                             at indexPath: IndexPath,
                             point: CGPoint) -> [UIDragItem] {
        guard
            indexPath.isSectionIndexValid(for: sections),
            session.localContext as? SectionController === sections[indexPath.section].controller,
            let dragDelegate = sections[indexPath.section].controller.dragDelegate
            else { return [] }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        return dragDelegate.dragItems(forAddingTo: session, at: sectionIndexPath, point: point)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard
            indexPath.isSectionIndexValid(for: sections),
            let dragDelegate = sections[indexPath.section].controller.dragDelegate
            else { return nil }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
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
