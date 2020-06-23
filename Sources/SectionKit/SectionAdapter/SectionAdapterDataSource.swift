import Foundation

/// A datasource which provides sections for an `UICollectionView`
public protocol SectionAdapterDataSource: AnyObject {
    /// Returns models for each section.
    func models(for adapter: SectionAdapter) -> [SectionModel]
    
    /// Returns the `SectionController` for the provided object
    func sectionController(with model: SectionModel,
                           for adapter: SectionAdapter) -> SectionController
}
