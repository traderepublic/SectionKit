import UIKit

/// A `SectionController` that handles a list of items.
open class ListSectionController<Model, Item>:
    BaseSectionController
{
    // MARK: - Properties
    
    open var cellProvider: ((CollectionContext, Item, SectionIndexPath) -> UICollectionViewCell)?
    
    open var sizeProvider: ((CollectionContext, Item, SectionIndexPath, UICollectionViewLayout) -> CGSize)?
    
    open var didSelect: ((CollectionContext, Item, SectionIndexPath) -> ())?
    
    // MARK: - SectionController
    
    override open func didUpdate(model: SectionModel) {
        guard let model = model as? Model else {
            assertionFailure("Could not cast model to \(String(describing: Model.self))")
            return
        }
        items = items(for: model)
    }
    
    open func items(for model: Model) -> [Item] {
        assertionFailure("items(for:) not implemented")
        return []
    }
    
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
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the section
     
     - Parameter newData: The new data that should be displayed in the section
     
     - Returns: The update that should be performed on the section
     */
    open func calculateUpdate(from oldData: [Item],
                              to newData: [Item]) -> SectionUpdate<[Item]> {
        return SectionUpdate(sectionController: self,
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
        return size(for: items[indexPath.internalRepresentation],
                    at: indexPath,
                    using: layout)
    }
    
    open func size(for item: Item,
                   at indexPath: SectionIndexPath,
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

