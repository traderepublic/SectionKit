import Foundation

/// A datasource which provides section controllers for a `CollectionViewAdapter`.
public protocol CollectionViewAdapterDataSource: AnyObject {
    /**
     Create a `SectionController` for the given model.

     - Parameter model: The model for which a `SectionController` should be created.

     - Parameter adapter: The adapter for which the `SectionController` is created.

     - Returns: A `SectionController` for the given model.
     If a `nil` value is returned the section will not display any cells.
     */
    func sectionController(with model: SectionModel,
                           for adapter: CollectionViewAdapter) -> SectionController?
}
