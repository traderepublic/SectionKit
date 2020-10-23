import UIKit

@available(iOS 10.0, *)
extension ListCollectionViewAdapter: UICollectionViewDataSourcePrefetching {
    open func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let validIndexPaths = indexPaths.filter { $0.isSectionIndexValid(for: sections) }
        validIndexPaths.group(by: \.section).forEach { sectionIndex, indexPaths in
            guard let prefetchingDelegate = sections[sectionIndex].controller?.dataSourcePrefetchingDelegate else {
                return
            }
            let sectionIndexPaths = indexPaths.map(SectionIndexPath.init)
            prefetchingDelegate.prefetchItems(at: sectionIndexPaths)
        }
    }

    open func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        let validIndexPaths = indexPaths.filter { $0.isSectionIndexValid(for: sections) }
        validIndexPaths.group(by: \.section).forEach { sectionIndex, indexPaths in
            guard let prefetchingDelegate = sections[sectionIndex].controller?.dataSourcePrefetchingDelegate else {
                return
            }
            let sectionIndexPaths = indexPaths.map(SectionIndexPath.init)
            prefetchingDelegate.cancelPrefetchingForItems(at: sectionIndexPaths)
        }
    }
}
