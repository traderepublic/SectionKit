import UIKit

/**
 The root object for a given `UICollectionView` that forwards datasource and delegate
 methods to the corresponding `SectionController`.
 */
public protocol CollectionViewAdapter: AnyObject {
    /// An object providing contextual information.
    var collectionContext: CollectionViewContext { get }

    /// A delegate that receives callbacks from the `UIScrollView`.
    var scrollViewDelegate: UIScrollViewDelegate? { get set }

    /// The sections in the `UICollectionView`.
    var sections: [Section] { get set }

    /// The datasource of this adapter responsible for creating `SectionControllers`.
    var dataSource: CollectionViewAdapterDataSource? { get set }

    /// If reordering is allowed between different sections.
    var allowReorderingBetweenDifferentSections: Bool { get set }

    /// Invalidate the current set of sections by requerying the `dataSource`.
    func invalidateDataSource()
}