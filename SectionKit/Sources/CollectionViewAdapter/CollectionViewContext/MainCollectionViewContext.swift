import UIKit

/// The main context which applies changes to the `UICollectionView` directly
open class MainCollectionViewContext: CollectionViewContext {
    // MARK: - Properties

    /// The adapter that is responsible for this context.
    public weak var adapter: CollectionViewAdapter?

    /// The `UIViewController` which contains the `collectionView`.
    public private(set) weak var viewController: UIViewController?

    /// The `UICollectionView` of which this context is responsible for.
    public let collectionView: UICollectionView

    /// The error handler of this context.
    public let errorHandler: ErrorHandling

    @usableFromInline
    internal var registeredCellTypes: Set<String> = []

    @usableFromInline
    internal var registeredHeaderViewTypes: Set<String> = []

    @usableFromInline
    internal var registeredFooterViewTypes: Set<String> = []

    // MARK: - Init

    /**
     Initialize an instance of `MainCollectionViewContext`.

     - Parameter viewController: The `UIViewController` which contains the `UICollectionView`.

     - Parameter collectionView: The `UICollectionView` of which this context is responsible for.

     - Parameter errorHandler: The error handler of this context.
     */
    public init(
        viewController: UIViewController?,
        collectionView: UICollectionView,
        errorHandler: ErrorHandling
    ) {
        self.viewController = viewController
        self.collectionView = collectionView
        self.errorHandler = errorHandler
    }

    // MARK: - Apply

    @inlinable
    open func apply<T>(update: CollectionViewSectionUpdate<T>) {
        guard let adapter = adapter else {
            errorHandler(error: .adapterIsNotSetOnContext)
            return collectionView.reloadData()
        }
        guard let index = adapter.sections.firstIndex(where: { $0.controller === update.controller }) else {
            errorHandler(error: .adapterDoesNotContainSectionController)
            return collectionView.reloadData()
        }
        collectionView.apply(update: update, at: index)
    }

    @inlinable
    open func apply<T>(update: CollectionViewUpdate<T>) {
        collectionView.apply(update: update)
    }

    // MARK: - Dequeueing reusable cells/views

    @inlinable
    open func dequeueReusableCell<Cell: UICollectionViewCell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell {
        let identifier = String(describing: cellType)
        if !registeredCellTypes.contains(identifier) {
            collectionView.register(cellType, forCellWithReuseIdentifier: identifier)
            registeredCellTypes.insert(identifier)
        }
        let dequeuedCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        )
        guard let cell = dequeuedCell as? Cell else {
            errorHandler(
                error: .dequeuedViewHasNotTheCorrectType(
                    expected: Cell.self,
                    actual: type(of: dequeuedCell)
                )
            )
            return Cell()
        }
        return cell
    }

    @inlinable
    open func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        let identifier = String(describing: viewType)
        let kind = UICollectionView.elementKindSectionHeader
        if !registeredHeaderViewTypes.contains(identifier) {
            collectionView.register(
                viewType,
                forSupplementaryViewOfKind: kind,
                withReuseIdentifier: identifier
            )
            registeredHeaderViewTypes.insert(identifier)
        }
        let dequeuedView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath
        )
        guard let view = dequeuedView as? SupplementaryView else {
            errorHandler(
                error: .dequeuedViewHasNotTheCorrectType(
                    expected: SupplementaryView.self,
                    actual: type(of: dequeuedView)
                )
            )
            return SupplementaryView()
        }
        return view
    }

    @inlinable
    open func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        let identifier = String(describing: viewType)
        let kind = UICollectionView.elementKindSectionFooter
        if !registeredFooterViewTypes.contains(identifier) {
            collectionView.register(
                viewType,
                forSupplementaryViewOfKind: kind,
                withReuseIdentifier: identifier
            )
            registeredFooterViewTypes.insert(identifier)
        }
        let dequeuedView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath
        )
        guard let view = dequeuedView as? SupplementaryView else {
            errorHandler(
                error: .dequeuedViewHasNotTheCorrectType(
                    expected: SupplementaryView.self,
                    actual: type(of: dequeuedView)
                )
            )
            return SupplementaryView()
        }
        return view
    }

    // MARK: - Sections

    @inlinable
    open func sectionControllerWithAdjustedIndexPath(
        for indexPath: IndexPath
    ) -> (SectionController?, SectionIndexPath)? {
        guard let adapter = adapter else {
            errorHandler(error: .adapterIsNotSetOnContext)
            return nil
        }
        let sectionIndex = indexPath.section
        let sections = adapter.sections
        guard sectionIndex < sections.count else {
            return nil
        }
        return (sections[sectionIndex].controller, SectionIndexPath(indexPath))
    }
}
