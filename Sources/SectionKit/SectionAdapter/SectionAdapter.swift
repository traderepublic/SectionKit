import UIKit

public protocol SectionAdapter: AnyObject {
    /// An object providing contextual information
    var collectionContext: CollectionContext { get }
    
    /// A delegate that receives callbacks from the `UIScrollView`
    var scrollViewDelegate: UIScrollViewDelegate? { get set }
    
    /// The list of sections in the `UICollectionView`.
    var sectionControllers: [SectionController] { get set }
    
    /// If reordering should be allowed between different sections
    var allowReorderingBetweenDifferentSections: Bool { get set }
}
