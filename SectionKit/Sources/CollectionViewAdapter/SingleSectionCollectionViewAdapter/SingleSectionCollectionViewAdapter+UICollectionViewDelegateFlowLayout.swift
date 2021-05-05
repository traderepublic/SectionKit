import UIKit

extension SingleSectionCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        guard let flowDelegate = flowDelegate(at: indexPath) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return CGSize(width: 50, height: 50)
            }
            return flowLayout.itemSize
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return flowDelegate.sizeForItem(at: sectionIndexPath, using: collectionViewLayout)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        guard let flowDelegate = flowDelegate(at: section) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return .zero
            }
            return flowLayout.sectionInset
        }
        return flowDelegate.inset(using: collectionViewLayout)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let flowDelegate = flowDelegate(at: section) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return 10
            }
            return flowLayout.minimumLineSpacing
        }
        return flowDelegate.minimumLineSpacing(using: collectionViewLayout)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        guard let flowDelegate = flowDelegate(at: section) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return 10
            }
            return flowLayout.minimumInteritemSpacing
        }
        return flowDelegate.minimumInteritemSpacing(using: collectionViewLayout)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let flowDelegate = flowDelegate(at: section) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return .zero
            }
            return flowLayout.headerReferenceSize
        }
        return flowDelegate.referenceSizeForHeader(using: collectionViewLayout)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard let flowDelegate = flowDelegate(at: section) else {
            guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return .zero
            }
            return flowLayout.footerReferenceSize
        }
        return flowDelegate.referenceSizeForFooter(using: collectionViewLayout)
    }
}
