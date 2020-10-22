import UIKit

extension ListCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard
            indexPath.isSectionIndexValid(for: sections),
            let flowDelegate = sections[indexPath.section].controller.flowDelegate
            else {
                return (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
        }
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath,
                                                indexInSectionController: indexPath.item)
        return flowDelegate.sizeForItem(at: sectionIndexPath, using: collectionViewLayout)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             insetForSectionAt section: Int) -> UIEdgeInsets {
        guard
            section >= 0 && section < sections.count,
            let flowDelegate = sections[section].controller.flowDelegate
            else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero }
        return flowDelegate.inset(using: collectionViewLayout)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        guard
            section >= 0 && section < sections.count,
            let flowDelegate = sections[section].controller.flowDelegate
            else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 10 }
        return flowDelegate.minimumLineSpacing(using: collectionViewLayout)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        guard
            section >= 0 && section < sections.count,
            let flowDelegate = sections[section].controller.flowDelegate
            else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10 }
        return flowDelegate.minimumInteritemSpacing(using: collectionViewLayout)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard
            section >= 0 && section < sections.count,
            let flowDelegate = sections[section].controller.flowDelegate
            else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero }
        return flowDelegate.referenceSizeForHeader(using: collectionViewLayout)
    }

    open func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForFooterInSection section: Int) -> CGSize {
        guard
            section >= 0 && section < sections.count,
            let flowDelegate = sections[section].controller.flowDelegate
            else { return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero }
        return flowDelegate.referenceSizeForFooter(using: collectionViewLayout)
    }
}
