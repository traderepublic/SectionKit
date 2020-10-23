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
        guard
            let indexPath = destinationIndexPath,
            indexPath.isSectionIndexValid(for: sections)
            else { return UICollectionViewDropProposal(operation: .forbidden) }
        if !allowReorderingBetweenDifferentSections {
            guard
                session.localDragSession?.localContext as? SectionController === sections[indexPath.section].controller
                else { return UICollectionViewDropProposal(operation: .forbidden) }
        }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        return sections[indexPath.section].controller?.dropDelegate?.dropSessionDidUpdate(session,
                                                                                          at: sectionIndexPath)
            ?? UICollectionViewDropProposal(operation: .forbidden)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard
            let indexPath = coordinator.destinationIndexPath,
            indexPath.isSectionIndexValid(for: sections)
            else { return }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        sections[indexPath.section].controller?.dropDelegate?.performDrop(at: sectionIndexPath,
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
        guard indexPath.isSectionIndexValid(for: sections) else { return nil }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        return sections[indexPath.section].controller?.dropDelegate?.dropPreviewParametersForItem(at: sectionIndexPath)
    }
}
