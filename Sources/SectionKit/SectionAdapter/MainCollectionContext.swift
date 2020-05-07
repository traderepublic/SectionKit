import UIKit

/// The main context which applies changes to the `UICollectionView` directly
open class MainCollectionContext: CollectionContext {
    
    // MARK: - Properties
    
    public private(set) weak var viewController: UIViewController?
    
    public let collectionView: UICollectionView
    
    private var registeredCellTypes: [UICollectionViewCell.Type] = []
    
    private var registeredHeaderViewTypes: [UICollectionReusableView.Type] = []
    
    private var registeredFooterViewTypes: [UICollectionReusableView.Type] = []
    
    public var sectionControllers: () -> [SectionController] = {
        assertionFailure("Did not set sectionControllers")
        return []
    }
    
    // MARK: - Initializer
    
    public init(viewController: UIViewController?,
                collectionView: UICollectionView) {
        self.viewController = viewController
        self.collectionView = collectionView
    }
    
    // MARK: - Container sizing and inset
    
    @inlinable
    open var containerSize: CGSize {
        collectionView.bounds.size
    }
    
    @inlinable
    open var containerInset: UIEdgeInsets {
        collectionView.contentInset
    }
    
    @inlinable
    open var adjustedContainerInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return collectionView.adjustedContentInset
        } else {
            return collectionView.contentInset
        }
    }
    
    @inlinable
    open var insetContainerSize: CGSize {
        collectionView.bounds.inset(by: adjustedContainerInset).size
    }
    
    // MARK: - Apply
    
    open func apply<T>(update: SectionUpdate<T>) {
        let sectionControllers = self.sectionControllers()
        guard let (sectionIndex, _) = sectionControllers.enumerated().first(where: { $1 === update.sectionController }) else {
            assertionFailure("No section controller was found for the specified id")
            return collectionView.reloadData()
        }
        collectionView.reload(using: update, at: sectionIndex)
    }
    
    open func apply<T>(update: CollectionUpdate<T>) {
        collectionView.reload(using: update)
    }
    
    // MARK: - Dequeueing reusable cells/views
    
    open func dequeueReusableCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type,
                                                              for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: cellType)
        if !registeredCellTypes.contains(where: { $0 == cellType }) {
            collectionView.register(cellType, forCellWithReuseIdentifier: identifier)
            registeredCellTypes.append(cellType)
        }
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? Cell
            else {
                assertionFailure("Could not cast the cell to the specified type")
                return Cell()
        }
        return cell
    }
    
    open func dequeueReusableHeaderView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        let identifier = String(describing: viewType)
        let kind = UICollectionView.elementKindSectionHeader
        if !registeredHeaderViewTypes.contains(where: { $0 == viewType }) {
            collectionView.register(viewType,
                                    forSupplementaryViewOfKind: kind,
                                    withReuseIdentifier: identifier)
            registeredHeaderViewTypes.append(viewType)
        }
        guard
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: identifier,
                                                                       for: indexPath) as? SupplementaryView
            else {
                assertionFailure("Could not cast the header view to the specified type")
                return SupplementaryView()
        }
        return view
    }
    
    open func dequeueReusableFooterView<SupplementaryView: UICollectionReusableView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView {
        let identifier = String(describing: viewType)
        let kind = UICollectionView.elementKindSectionFooter
        if !registeredFooterViewTypes.contains(where: { $0 == viewType }) {
            collectionView.register(viewType,
                                    forSupplementaryViewOfKind: kind,
                                    withReuseIdentifier: identifier)
            registeredFooterViewTypes.append(viewType)
        }
        guard
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: identifier,
                                                                       for: indexPath) as? SupplementaryView
            else {
                assertionFailure("Could not cast the footer view to the specified type")
                return SupplementaryView()
        }
        return view
    }
    
    // MARK: - Sections
    
    open func sectionControllerWithAdjustedIndexPath(for indexPath: IndexPath) -> (SectionController, SectionIndexPath)? {
        var sectionIndexPath = indexPath
        var sectionIndex = indexPath.section
        let sectionControllers = self.sectionControllers()
        if sectionIndex >= sectionControllers.count {
            // index of section is out of bounds, select last section instead
            sectionIndex = sectionControllers.count - 1
            sectionIndexPath = IndexPath(item: sectionControllers[sectionIndex].dataSource.numberOfItems,
                                         section: sectionIndex)
        }
        return (sectionControllers[sectionIndex], SectionIndexPath(sectionIndexPath))
    }
}

