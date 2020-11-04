import Foundation

/// A datasource which provides a single section controller for a `CollectionViewAdapter`.
public protocol SingleSectionCollectionViewAdapterDataSource: CollectionViewAdapterDataSource {
    /**
     Queries the a model for the single section in the `UICollectionView`.

     - Parameter adapter: The adapter for which the section models are queried.

     - Returns: A model for the single section in the `UICollectionView`.
     */
    func model(for adapter: CollectionViewAdapter) -> SectionModel?
}
