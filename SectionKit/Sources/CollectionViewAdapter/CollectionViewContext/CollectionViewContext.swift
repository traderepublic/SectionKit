import UIKit

/// A context which provides contextual information for a `SectionController`.
public protocol CollectionViewContext: AnyObject {
    /// The `UIViewController` which contains the `collectionView`.
    var viewController: UIViewController? { get }

    /// The `UICollectionView` of which this context is responsible for.
    var collectionView: UICollectionView { get }

    /// The error handler of this context.
    var errorHandler: ErrorHandling { get }

    /**
     Apply an update to the items of the current section.
     
     - Parameter update: The update to apply to the current section.
     */
    func apply<T>(update: CollectionViewSectionUpdate<T>)

    /**
     Apply an update to the sections in the `UICollectionView`.
     
     - Parameter update: The update to apply to the sections in the `UICollectionView`.
     */
    func apply<T>(update: CollectionViewUpdate<T>)

    /**
     Dequeue a reusable cell with the given cell type.
     
     - Note: The cell type will get registered automatically if it's not already registered.
     
     - Parameter cellType: The type of cell to dequeue.
     
     - Parameter indexPath: The `IndexPath` where the cell will be displayed.
     
     - Returns: The dequeued cell for the given `IndexPath`.
     */
    func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell

    /**
     Dequeue a reusable view to be used as a header with the given view type.
     
     - Note: The view type will get registered automatically if it's not already registered.
     
     - Parameter viewType: The type of view to dequeue.
     
     - Parameter indexPath: The `IndexPath` where the header will be displayed.
     
     - Returns: The dequeued view for the given `IndexPath`.
     */
    func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView

    /**
     Dequeue a reusable view to be used as a footer with the given view type.
     
     - Note: The view type will get registered automatically if it's not already registered.
     
     - Parameter viewType: The type of view to dequeue.
     
     - Parameter indexPath: The `IndexPath` where the footer will be displayed.
     
     - Returns: The dequeued view for the given `IndexPath`.
     */
    func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView

    /**
     Get the `SectionController` which is responsible for the given `IndexPath` and calculate
     an adjusted `SectionIndexPath`.
     
     - Parameter indexPath: The `IndexPath` of which the responsible `SectionController` should be determined.
     
     - Returns: The `SectionController` which is responsible for the given `IndexPath` and
     the corresponding `SectionIndexPath`.
     */
    func sectionControllerWithAdjustedIndexPath(for indexPath: IndexPath) -> (SectionController?, SectionIndexPath)?

    /**
     Get the index of the given `SectionController` in this context.

     - Parameter controller: The `SectionController` of which the index should be retrieved.

     - Returns: The index of the given `SectionController` in this context.
     */
    func index(of controller: SectionController) -> Int?
}

extension CollectionViewContext {
    /**
     Dequeue a reusable cell with the given cell type.

     - Note: The cell type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the cell will be displayed.

     - Returns: The dequeued cell for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(Cell.self, for: indexPath)
    }

    /**
     Dequeue a reusable cell with the given cell type.

     - Note: The cell type will get registered automatically if it's not already registered.

     - Parameter cellType: The type of cell to dequeue.

     - Parameter indexPath: The `IndexPath` where the cell will be displayed.

     - Returns: The dequeued cell for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: SectionIndexPath
    ) -> Cell {
        dequeueReusableCell(cellType, for: indexPath.indexInCollectionView)
    }

    /**
     Dequeue a reusable cell with the given cell type.

     - Note: The cell type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the cell will be displayed.

     - Returns: The dequeued cell for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: SectionIndexPath) -> Cell {
        dequeueReusableCell(Cell.self, for: indexPath.indexInCollectionView)
    }

    /**
     Dequeue a reusable view to be used as a header with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the header will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        for indexPath: IndexPath
    ) -> SupplementaryView {
        dequeueReusableHeaderView(SupplementaryView.self, for: indexPath)
    }

    /**
     Dequeue a reusable view to be used as a header with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter viewType: The type of view to dequeue.

     - Parameter indexPath: The `IndexPath` where the header will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: SectionIndexPath
    ) -> SupplementaryView {
        dequeueReusableHeaderView(viewType, for: indexPath.indexInCollectionView)
    }

    /**
     Dequeue a reusable view to be used as a header with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the header will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        for indexPath: SectionIndexPath
    ) -> SupplementaryView {
        dequeueReusableHeaderView(SupplementaryView.self, for: indexPath.indexInCollectionView)
    }

    /**
     Dequeue a reusable view to be used as a footer with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the footer will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        for indexPath: IndexPath
    ) -> SupplementaryView {
        dequeueReusableFooterView(SupplementaryView.self, for: indexPath)
    }

    /**
     Dequeue a reusable view to be used as a footer with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter viewType: The type of view to dequeue.

     - Parameter indexPath: The `IndexPath` where the footer will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: SectionIndexPath
    ) -> SupplementaryView {
        dequeueReusableFooterView(viewType, for: indexPath.indexInCollectionView)
    }

    /**
     Dequeue a reusable view to be used as a footer with the given view type.

     - Note: The view type will get registered automatically if it's not already registered.

     - Parameter indexPath: The `IndexPath` where the footer will be displayed.

     - Returns: The dequeued view for the given `IndexPath`.
     */
    @inlinable
    public func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        for indexPath: SectionIndexPath
    ) -> SupplementaryView {
        dequeueReusableFooterView(SupplementaryView.self, for: indexPath.indexInCollectionView)
    }
}
