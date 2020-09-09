import Foundation

/// A datasource which provides sections for an `UICollectionView`
public protocol CollectionViewAdapterDataSource: AnyObject {
    /**
     Queries the list of models for each section in the `UICollectionView`.

     - Parameter adapter: The adapter for which the section models are queried.

     - Returns: A list of models for each section in the `UICollectionView`.
     */
    func models(for adapter: CollectionViewAdapter) -> [SectionModel]

    /**
     Create a `SectionController` for the given model.

     - Parameter model: The model for which a `SectionController` should be created.

     - Parameter adapter: The adapter for which the `SectionController` is created.

     - Returns: A `SectionController` for the given model.
     */
    func sectionController(with model: SectionModel,
                           for adapter: CollectionViewAdapter) -> SectionController
}
