import Foundation

/// A datasource which provides sections for an `UICollectionView`
public protocol SectionAdapterDataSource: AnyObject {
    /// Returns objects for each section.
    func objects(for adapter: SectionAdapter) -> [SectionAdapterObject]
    
    /// Returns the `SectionController` for the provided object
    func sectionController(with model: AnyHashable, for adapter: SectionAdapter) -> SectionController
}
