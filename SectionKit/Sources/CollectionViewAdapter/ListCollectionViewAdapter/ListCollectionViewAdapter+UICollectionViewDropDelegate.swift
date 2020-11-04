import UIKit

@available(iOS 11.0, *)
extension ListCollectionViewAdapter: UICollectionViewDropDelegate {
    open func collectionView(_ collectionView: UICollectionView,
                             canHandle session: UIDropSession) -> Bool {
        return sections.contains { $0.controller?.dropDelegate?.canHandle(drop: session) ?? true }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UICollectionViewDropProposal {
        guard let indexPath = destinationIndexPath else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        guard let dropDelegate = dropDelegate(at: indexPath) else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        if !allowReorderingBetweenDifferentSections {
            guard session.localDragSession?.localContext as? SectionController === controller(at: indexPath) else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dropDelegate.dropSessionDidUpdate(session, at: sectionIndexPath)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let indexPath = coordinator.destinationIndexPath else {
            return
        }
        guard let dropDelegate = dropDelegate(at: indexPath) else {
            return
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        dropDelegate.performDrop(at: sectionIndexPath, with: coordinator)
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
        guard let dropDelegate = dropDelegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dropDelegate.dropPreviewParametersForItem(at: sectionIndexPath)
    }
}
