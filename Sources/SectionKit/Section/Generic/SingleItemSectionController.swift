import UIKit

open class SingleItemSectionController<Model: SectionModel, Item: Equatable>: BaseSectionController {
    
    // MARK: - SectionController
    
    open var model: Model {
        didSet {
            item = item(for: model)
        }
    }
    
    public init(model: Model) {
        self.model = model
        super.init()
        item = item(for: model)
    }
    
    override open func didUpdate(model: SectionModel) {
        guard let model = model as? Model else {
            assertionFailure("Could not cast model to \(String(describing: Model.self))")
            return
        }
        self.model = model
    }
    
    open func item(for model: Model) -> Item? {
        assertionFailure("item(for:) not implemented")
        return nil
    }
    
    /**
     The item currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `item` instead.
     */
    open var collectionViewItem: Item?
    
    open var item: Item? {
        get { collectionViewItem }
        set {
            guard let context = context else {
                collectionViewItem = newValue
                return
            }
            let sectionUpdate = calculateUpdate(from: collectionViewItem, to: newValue)
            context.apply(update: sectionUpdate)
        }
    }
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the section
     
     - Parameter newData: The new data that should be displayed in the section
     
     - Returns: The update that should be performed on the section
     */
    open func calculateUpdate(from oldData: Item?,
                              to newData: Item?) -> SectionUpdate<Item?> {
        let changes: Set<SectionChange>
        switch (oldData, newData) {
        case let (.some(old), .some(new)):
            if old == new {
                changes = []
            } else {
                changes = [.reloadItem(at: 0)]
            }
        case (.some, .none):
            changes = [.deleteItem(at: 0)]
        case (.none, .some):
            changes = [.insertItem(at: 0)]
        case (.none, .none):
            changes = []
        }
        return SectionUpdate(sectionId: model.sectionId,
                             changes: changes,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItem = $0 })
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        return item != nil ? 1 : 0
    }
    
    override open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        guard let item = item else {
            fatalError("\(#function): Item is not set")
        }
        return cell(for: item, at: indexPath)
    }
    
    open func cell(for item: Item, at indexPath: SectionIndexPath) -> UICollectionViewCell {
        assertionFailure("cell(for:at:) not implemented")
        return UICollectionViewCell()
    }
    
    // MARK: - SectionDelegate
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        guard let item = item else {
            fatalError("\(#function): Item is not set")
        }
        didSelect(item: item, at: indexPath)
    }
    
    open func didSelect(item: Item, at indexPath: SectionIndexPath) { }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        guard let item = item else {
            fatalError("\(#function): Item is not set")
        }
        return size(for: item,
                    at: indexPath,
                    using: layout)
    }
    
    open func size(for item: Item,
                   at indexPath: SectionIndexPath,
                   using layout: UICollectionViewLayout) -> CGSize {
        return super.sizeForItem(at: indexPath, using: layout)
    }
}
