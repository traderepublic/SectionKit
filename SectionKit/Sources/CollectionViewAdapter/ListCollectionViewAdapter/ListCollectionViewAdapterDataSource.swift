import Foundation

/// A datasource which provides a list of section controllers for a `CollectionViewAdapter`.
public protocol ListCollectionViewAdapterDataSource: CollectionViewAdapterDataSource {
    /**
     Queries the list of models for each section in the `UICollectionView`.

     - Parameter adapter: The adapter for which the section models are queried.

     - Returns: A list of models for each section in the `UICollectionView`.
     */
    func models(for adapter: CollectionViewAdapter) -> [SectionModel]
}
