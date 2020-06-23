import UIKit

/// An object for a `SectionController` which provides contextual information
public protocol CollectionContext: AnyObject {
    /// The `UIViewController` which owns the `UICollectionView`
    var viewController: UIViewController? { get }
    
    /// The current `UICollectionView`
    var collectionView: UICollectionView { get }
    
    /// The size of the `UICollectionView`
    var containerSize: CGSize { get }
    
    /// The insets of the content view from the safe area or scroll view edges.
    var containerInset: UIEdgeInsets { get }
    
    /// The insets derived from the content insets and the safe area of the scroll view.
    var adjustedContainerInset: UIEdgeInsets { get }
    
    /// The size of the `UICollectionView` inset by the `adjustedContainerInset`
    var insetContainerSize: CGSize { get }
    
    /**
     Apply an update to the items of the current section
     
     - Parameter update: The update to apply to the current section
     */
    func apply<T>(update: SectionUpdate<T>)
    
    /**
     Apply an update to the sections of the `UICollectionView`
     
     - Parameter update: The update to apply to the sections of the `UICollectionView`
     */
    func apply<T>(update: CollectionUpdate<T>)
    
    /**
     Dequeue a reusable cell with the given cell type
     
     The cell type will get registered automatically if it's not already registered.
     
     - Parameter cellType: The type of cell to dequeue
     
     - Parameter indexPath: The `IndexPath` where the cell will be displayed
     
     - Returns: The dequeued cell for the given `IndexPath`
     */
    func dequeueReusableCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type,
                                                         for indexPath: IndexPath) -> Cell
    
    /**
     Dequeue a reusable view to be used as a header with the given view type
     
     The view type will get registered automatically if it's not already registered.
     
     - Parameter viewType: The type of view to dequeue
     
     - Parameter indexPath: The `IndexPath` where the header will be displayed
     
     - Returns: The dequeued view for the given `IndexPath`
     */
    func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView
    
    /**
     Dequeue a reusable view to be used as a footer with the given view type
     
     The view type will get registered automatically if it's not already registered.
     
     - Parameter viewType: The type of view to dequeue
     
     - Parameter indexPath: The `IndexPath` where the footer will be displayed
     
     - Returns: The dequeued view for the given `IndexPath`
     */
    func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView
    
    /**
     Get the `SectionController` which is responsible for the given `IndexPath` and the adjusted `SectionIndexPath`
     
     - Parameter indexPath: The `IndexPath` of which the responsible `SectionController` should be determined
     
     - Returns: The `SectionController` which is responsible for the given `IndexPath` and the adjusted `SectionIndexPath`
     */
    func sectionControllerWithAdjustedIndexPath(for indexPath: IndexPath) -> (SectionController, SectionIndexPath)?
}

