import Foundation

/// A datasource which provides a single section for a `CollectionViewAdapter`.
public protocol SingleSectionCollectionViewAdapterDataSource: AnyObject {
    /**
     Queries the single section in the `UICollectionView`.

     - Parameter adapter: The adapter for which the section models are queried.

     - Returns: The single section in the `UICollectionView`.
     */
    func section(for adapter: CollectionViewAdapter) -> Section?
}
