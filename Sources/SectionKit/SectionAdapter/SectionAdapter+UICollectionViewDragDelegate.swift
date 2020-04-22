import UIKit

@available(iOS 11.0, *)
extension SectionAdapter: UICollectionViewDragDelegate {
    open func collectionView(_ collectionView: UICollectionView,
                             itemsForBeginning session: UIDragSession,
                             at indexPath: IndexPath) -> [UIDragItem] {
        guard
            indexPath.section >= 0 && indexPath.section < sectionControllers.count,
            let dragDelegate = sectionControllers[indexPath.section].dragDelegate
            else { return [] }
        session.localContext = sectionControllers[indexPath.section].id
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return dragDelegate.dragItems(forBeginning: session, at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             itemsForAddingTo session: UIDragSession,
                             at indexPath: IndexPath,
                             point: CGPoint) -> [UIDragItem] {
        guard
            indexPath.section >= 0 && indexPath.section < sectionControllers.count,
            session.localContext as? UUID == sectionControllers[indexPath.section].id,
            let dragDelegate = sectionControllers[indexPath.section].dragDelegate
            else { return [] }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return dragDelegate.dragItems(forAddingTo: session, at: sectionIndexPath, point: point)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard
            indexPath.section >= 0 && indexPath.section < sectionControllers.count,
            let dragDelegate = sectionControllers[indexPath.section].dragDelegate
            else { return nil }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
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

