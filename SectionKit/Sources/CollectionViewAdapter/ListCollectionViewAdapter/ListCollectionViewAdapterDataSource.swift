import Foundation

/// A datasource which provides a list of sections for a `CollectionViewAdapter`.
@MainActor
public protocol ListCollectionViewAdapterDataSource: AnyObject {
    /**
     Queries the list of sections in the `UICollectionView`.

     - Parameter adapter: The adapter for which the section models are queried.

     - Returns: A list of sections in the `UICollectionView`.
     */
    func sections(for adapter: CollectionViewAdapter) -> [Section]
}
