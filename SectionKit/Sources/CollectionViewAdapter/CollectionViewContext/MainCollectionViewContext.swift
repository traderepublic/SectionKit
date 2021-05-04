import UIKit

/// The main context which applies changes to the `UICollectionView` directly
open class MainCollectionViewContext: CollectionViewContext {
    // MARK: - Properties

    public weak var sectionAdapter: CollectionViewAdapter?

    public private(set) weak var viewController: UIViewController?

    public let collectionView: UICollectionView

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

     - Parameter collectionView: The `UICollectionView` of this context.
     */
    public init(
        viewController: UIViewController?,
        collectionView: UICollectionView
    ) {
        self.viewController = viewController
        self.collectionView = collectionView
    }

    // MARK: - Apply

    @inlinable
    open func apply<T>(update: CollectionViewSectionUpdate<T>) {
        guard let sectionAdapter = sectionAdapter else {
            assertionFailure("`sectionAdapter` is no set")
            return collectionView.reloadData()
        }
        guard let index = sectionAdapter.sections.firstIndex(where: { $0.controller === update.controller }) else {
            assertionFailure("No section was found for the specified id")
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
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? Cell else {
            assertionFailure("Could not cast the cell to the specified type")
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
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? SupplementaryView else {
            assertionFailure("Could not cast the header view to the specified type")
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
        guard let view = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: identifier,
            for: indexPath
        ) as? SupplementaryView else {
            assertionFailure("Could not cast the footer view to the specified type")
            return SupplementaryView()
        }
        return view
    }

    // MARK: - Sections

    @inlinable
    open func sectionControllerWithAdjustedIndexPath(
        for indexPath: IndexPath
    ) -> (SectionController?, SectionIndexPath)? {
        guard let sectionAdapter = sectionAdapter else {
            assertionFailure("`sectionAdapter` is no set")
            return nil
        }
        let sectionIndex = indexPath.section
        let sections = sectionAdapter.sections
        guard sectionIndex < sections.count else { return nil }
        return (sections[sectionIndex].controller, SectionIndexPath(indexPath))
    }
}
