import UIKit

/**
 The root object for a given `UICollectionView` that forwards datasource and delegate
 methods to the corresponding `SectionController`.
 */
@MainActor
public protocol CollectionViewAdapter: AnyObject {
    /// An object providing contextual information.
    var context: CollectionViewContext { get }

    /// A delegate that receives callbacks from the `UIScrollView`.
    var scrollViewDelegate: UIScrollViewDelegate? { get set }

    /// The sections in the `UICollectionView`.
    var sections: [Section] { get }

    /// Invalidate the current set of sections by querying the `dataSource` again.
    func invalidateDataSource()
}
