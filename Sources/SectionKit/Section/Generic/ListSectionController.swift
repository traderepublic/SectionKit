import UIKit

/// A `SectionController` that handles a list of items.
open class ListSectionController<Model: SectionModel, Item>: BaseSectionController {
    
    // MARK: - SectionController
    
    open var model: Model {
        didSet {
            if shouldUpdateItems(afterModelChangedTo: model) {
                items = items(for: model)
            }
        }
    }

    open func shouldUpdateItems(afterModelChangedTo model: Model) -> Bool {
        return true
    }
    
    public init(model: Model) {
        self.model = model
        super.init()
        if shouldUpdateItem(afterModelChangedTo: model) {
            items = items(for: model)
        }
    }
    
    override open func didUpdate(model: SectionModel) {
        guard let model = model as? Model else {
            assertionFailure("Could not cast model to \(String(describing: Model.self))")
            return
        }
        self.model = model
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
            if let sectionUpdate = calculateUpdate(from: collectionViewItems, to: newValue) {
                context.apply(update: sectionUpdate)
            }
        }
    }
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the section
     
     - Parameter newData: The new data that should be displayed in the section
     
     - Returns: The update that should be performed on the section
     */
    open func calculateUpdate(from oldData: [Item],
                              to newData: [Item]) -> SectionUpdate<[Item]>? {
        return SectionUpdate(sectionId: model.sectionId,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewItems = $0 })
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        items.count
    }
}

