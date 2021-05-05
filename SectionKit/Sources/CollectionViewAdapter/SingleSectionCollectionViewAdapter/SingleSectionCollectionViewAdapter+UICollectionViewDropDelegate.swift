import UIKit

@available(iOS 11.0, *)
extension SingleSectionCollectionViewAdapter: UICollectionViewDropDelegate {
    open func collectionView(
        _ collectionView: UICollectionView,
        canHandle session: UIDropSession
    ) -> Bool {
        guard let sectionController = session.localDragSession?.localContext as? SectionController else {
            return false
        }
        guard let dropDelegate = sectionController.dropDelegate else {
            return false
        }
        return dropDelegate.canHandle(drop: session)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UICollectionViewDropProposal {
        guard let sectionController = session.localDragSession?.localContext as? SectionController else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        if let destinationIndexPath = destinationIndexPath, controller(at: destinationIndexPath) !== sectionController {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        guard let dropDelegate = sectionController.dropDelegate else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
        let sectionIndexPath: SectionIndexPath?
        if let destinationIndexPath = destinationIndexPath, destinationIndexPath.isValid {
            sectionIndexPath = SectionIndexPath(destinationIndexPath)
        } else {
            sectionIndexPath = nil
        }
        return dropDelegate.dropSessionDidUpdate(session, at: sectionIndexPath)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        performDropWith coordinator: UICollectionViewDropCoordinator
    ) {
        guard let sectionController = coordinator.session.localDragSession?.localContext as? SectionController else {
            return
        }
        let allItemsOriginateFromSectionController = coordinator.items.allSatisfy({ item in
            guard let itemIndexPath = item.sourceIndexPath else {
                return false
            }
            return controller(at: itemIndexPath) === sectionController
        })
        guard allItemsOriginateFromSectionController else {
            return
        }
        if let destinationIndexPath = coordinator.destinationIndexPath,
           controller(at: destinationIndexPath) !== sectionController {
            return
        }
        guard let dropDelegate = sectionController.dropDelegate else {
            return
        }
        let sectionIndexPath: SectionIndexPath?
        if let destinationIndexPath = coordinator.destinationIndexPath, destinationIndexPath.isValid {
            sectionIndexPath = SectionIndexPath(destinationIndexPath)
        } else {
            sectionIndexPath = nil
        }
        dropDelegate.performDrop(at: sectionIndexPath, with: coordinator)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidEnter session: UIDropSession
    ) {
        section?.controller.dropDelegate?.dropSessionDidEnter(session)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidExit session: UIDropSession
    ) {
        section?.controller.dropDelegate?.dropSessionDidExit(session)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidEnd session: UIDropSession
    ) {
        section?.controller.dropDelegate?.dropSessionDidEnd(session)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropPreviewParametersForItemAt indexPath: IndexPath
    ) -> UIDragPreviewParameters? {
        guard let dropDelegate = dropDelegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dropDelegate.dropPreviewParametersForItem(at: sectionIndexPath)
    }
}
