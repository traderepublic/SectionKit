import UIKit

@available(iOS 10.0, *)
extension ListCollectionViewAdapter: UICollectionViewDataSourcePrefetching {
    open func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let validIndexPaths = indexPaths.filter(\.isValid)
        Dictionary(grouping: validIndexPaths, by: \.section).forEach { sectionIndex, indexPaths in
            guard let dataSourcePrefetchingDelegate = dataSourcePrefetchingDelegate(at: sectionIndex) else {
                return
            }
            let sectionIndexPaths = indexPaths.map(SectionIndexPath.init)
            dataSourcePrefetchingDelegate.prefetchItems(at: sectionIndexPaths, in: context)
        }
    }

    open func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        let validIndexPaths = indexPaths.filter(\.isValid)
        Dictionary(grouping: validIndexPaths, by: \.section).forEach { sectionIndex, indexPaths in
            guard let dataSourcePrefetchingDelegate = dataSourcePrefetchingDelegate(at: sectionIndex) else {
                return
            }
            let sectionIndexPaths = indexPaths.map(SectionIndexPath.init)
            dataSourcePrefetchingDelegate.cancelPrefetchingForItems(at: sectionIndexPaths, in: context)
        }
    }
}
