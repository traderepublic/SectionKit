import UIKit

/// The root object for a given `UICollectionView` that forwards datasource and delegate methods to the corresponding `SectionController`
public protocol SectionAdapter: AnyObject {
    /// An object providing contextual information
    var collectionContext: CollectionContext { get }
    
    /// A delegate that receives callbacks from the `UIScrollView`
    var scrollViewDelegate: UIScrollViewDelegate? { get set }
    
    /// Sections in this adapter
    var sections: [Section] { get set }
    
    /// The datasource of this adapter responsible for creating `SectionControllers`
    var dataSource: SectionAdapterDataSource? { get set }
    
    /// If reordering should be allowed between different sections
    var allowReorderingBetweenDifferentSections: Bool { get set }
    
    /// Tells the adapter to query the `dataSource` again
    func invalidateDataSource()
}
