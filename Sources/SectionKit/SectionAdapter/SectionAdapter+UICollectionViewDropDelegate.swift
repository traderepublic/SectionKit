import UIKit

@available(iOS 11.0, *)
extension SectionAdapter: UICollectionViewDropDelegate {
    open func collectionView(_ collectionView: UICollectionView,
                             canHandle session: UIDropSession) -> Bool {
        return sectionControllers.contains { $0.dropDelegate?.canHandle(drop: session) ?? true }
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dropSessionDidUpdate session: UIDropSession,
                             withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        guard
            let indexPath = destinationIndexPath,
            indexPath.section >= 0 && indexPath.section < sectionControllers.count
            else { return UICollectionViewDropProposal(operation: .forbidden) }
        if !allowReorderingBetweenDifferentSections {
            guard
                let dragSectionId = session.localDragSession?.localContext as? UUID,
                dragSectionId == sectionControllers[indexPath.section].id
                else { return UICollectionViewDropProposal(operation: .forbidden) }
        }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sectionControllers[indexPath.section].dropDelegate?.dropSessionDidUpdate(session,
                                                                                        at: sectionIndexPath)
            ?? UICollectionViewDropProposal(operation: .forbidden)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard
            let indexPath = coordinator.destinationIndexPath,
            indexPath.section >= 0 && indexPath.section < sectionControllers.count
            else { return }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        sectionControllers[indexPath.section].dropDelegate?.performDrop(at: sectionIndexPath,
                                                                        with: coordinator)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dropSessionDidEnter session: UIDropSession) {
        
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dropSessionDidExit session: UIDropSession) {
        
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dropSessionDidEnd session: UIDropSession) {
        
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             dropPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard indexPath.section >= 0 && indexPath.section < sectionControllers.count else { return nil }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sectionControllers[indexPath.section].dropDelegate?.dropPreviewParametersForItem(at: sectionIndexPath)
    }
}

