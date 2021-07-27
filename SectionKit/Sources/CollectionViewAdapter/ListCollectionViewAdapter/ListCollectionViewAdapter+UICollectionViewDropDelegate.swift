import UIKit

@available(iOS 11.0, *)
extension ListCollectionViewAdapter: UICollectionViewDropDelegate {
    open func collectionView(
        _ collectionView: UICollectionView,
        canHandle session: UIDropSession
    ) -> Bool {
        sections.compactMap(\.controller.dropDelegate).contains {
            $0.canHandle(drop: session, in: context)
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidUpdate session: UIDropSession,
        withDestinationIndexPath destinationIndexPath: IndexPath?
    ) -> UICollectionViewDropProposal {
        let dropDelegate: SectionDropDelegate
        let sectionIndexPath: SectionIndexPath?
        if let destinationIndexPath = destinationIndexPath, destinationIndexPath.isValid {
            guard let sectionController = controller(at: destinationIndexPath) else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            guard let delegate = sectionController.dropDelegate else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            dropDelegate = delegate
            sectionIndexPath = SectionIndexPath(destinationIndexPath)
        } else {
            let dropLocation = session.location(in: context.collectionView)
            guard let dropIndexPath = collectionView.indexPathForItem(at: dropLocation) else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            guard let sectionController = controller(at: dropIndexPath) else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            guard let delegate = sectionController.dropDelegate else {
                return UICollectionViewDropProposal(operation: .forbidden)
            }
            dropDelegate = delegate
            sectionIndexPath = nil
        }
        return dropDelegate.dropSessionDidUpdate(session, at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        performDropWith coordinator: UICollectionViewDropCoordinator
    ) {
        guard let destinationIndexPath = coordinator.destinationIndexPath, destinationIndexPath.isValid else {
            return
        }
        guard coordinator.items.allSatisfy({ item in
            guard let itemIndexPath = item.sourceIndexPath, itemIndexPath.isValid else {
                return true // if the item doesn't originate from the collectionview, we support the drop anyways
            }
            // since it has a source index, we validate that it originates from the same section
            // if it's from a different section it would involve a second sectioncontroller, which is not yet supported
            return itemIndexPath.section == destinationIndexPath.section
        }) else {
            return
        }
        guard let sectionController = controller(at: destinationIndexPath) else {
            return
        }
        guard let dropDelegate = sectionController.dropDelegate else {
            return
        }
        let sectionIndexPath = SectionIndexPath(destinationIndexPath)
        dropDelegate.performDrop(at: sectionIndexPath, with: coordinator, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidEnter session: UIDropSession
    ) {
        sections.compactMap(\.controller.dropDelegate).forEach { $0.dropSessionDidEnter(session, in: context) }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidExit session: UIDropSession
    ) {
        sections.compactMap(\.controller.dropDelegate).forEach { $0.dropSessionDidExit(session, in: context) }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropSessionDidEnd session: UIDropSession
    ) {
        sections.compactMap(\.controller.dropDelegate).forEach { $0.dropSessionDidEnd(session, in: context) }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        dropPreviewParametersForItemAt indexPath: IndexPath
    ) -> UIDragPreviewParameters? {
        guard let dropDelegate = dropDelegate(at: indexPath) else {
            return nil
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dropDelegate.dropPreviewParametersForItem(at: sectionIndexPath, in: context)
    }
}
