import UIKit

/// A `SectionController` that handles a list of items.
open class ListSectionController<Item>:
    BaseSectionController,
    ListSectionControllerProtocol
{
    // MARK: - Properties
    
    private let _id: String
    override open var id: String { _id }
    
    open var cellProvider: ((CollectionContext, Item, SectionIndexPath) -> UICollectionViewCell)?
    
    open var sizeProvider: ((CollectionContext, Item, SectionIndexPath, UICollectionViewLayout) -> CGSize)?
    
    open var didSelect: ((CollectionContext, Item, SectionIndexPath) -> ())?
    
    // MARK: - Init
    
    public init(id: String) {
        self._id = id
        super.init()
    }
    
    override public convenience init() {
        self.init(id: UUID().uuidString)
    }
    
    // MARK: - ListSectionControllerProtocol
    
    /**
     The list of items currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `items` instead.
     */
    open var collectionViewItems: [Item] = []
    
    open var items: [Item] {
        get { collectionViewItems }
        set {
            guard let context = context else {
                collectionViewItems = newValue
                return
            }
            let sectionUpdate = calculateUpdate(from: collectionViewItems,
                                                to: newValue)
            context.apply(update: sectionUpdate)
        }
    }
    
    open func calculateUpdate(from oldData: [Item],
                              to newData: [Item]) -> SectionUpdate<[Item]> {
        return SectionUpdate(sectionId: id,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 })
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        items.count
    }
    
    override open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        guard let context = context else {
            assertionFailure("Did not set `context` before calling \(#function)")
            return UICollectionViewCell()
        }
        guard let cellProvider = cellProvider else {
            assertionFailure("Did not set `cellProvider` before calling \(#function)")
            return UICollectionViewCell()
        }
        let item = items[indexPath.internalRepresentation]
        return cellProvider(context, item, indexPath)
    }
    
    // MARK: - SectionDelegate
    
    override open func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        return didSelect != nil
    }
    
    override open func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        return didSelect != nil
    }
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        guard let context = context else {
            assertionFailure("Did not set `context` before calling \(#function)")
            return
        }
        let item = items[indexPath.internalRepresentation]
        didSelect?(context, item, indexPath)
    }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        guard let context = context else {
            assertionFailure("Did not set `context` before calling \(#function)")
            return .zero
        }
        let item = items[indexPath.internalRepresentation]
        return sizeProvider?(context, item, indexPath, layout)
            ?? super.sizeForItem(at: indexPath, using: layout)
    }
}

