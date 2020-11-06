import UIKit

/**
 A `SectionController` that displays a single item derived of a single model.

 This `SectionController` is typically used when one item should be displayed conditionally.
 If however multiple items should be displayed, it is recommended to use `ListSectionController` instead.

 - Warning: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
 */
open class SingleItemSectionController<Model, Item>: BaseSectionController {
    /**
     Initialize an instance of `SingleItemSectionController`.

     - Parameter model: The model of this `SectionController`.
     */
    public init(model: Model) {
        self.model = model
        super.init()
        if shouldUpdateItem(afterModelChangedTo: model) {
            item = item(for: model)
        }
    }

    override open func didUpdate(model: Any) {
        guard let model = model as? Model else {
            assertionFailure("Could not cast model to \(String(describing: Model.self))")
            return
        }
        self.model = model
    }

    /// The model of this `SectionController`.
    open var model: Model {
        didSet {
            if shouldUpdateItem(afterModelChangedTo: model) {
                item = item(for: model)
            }
        }
    }

    /**
     Determines if the item should be updated after the model was updated to a new value.

     The default value is `true`.

     - Parameter model: The new value of the model.

     - Returns: If the item should be updated after the model was updated to a new value.
     */
    open func shouldUpdateItem(afterModelChangedTo model: Model) -> Bool {
        return true
    }

    /**
     Derives the item from the given `Model`.

     Will be called automatically if `shouldUpdateItem(afterModelChangedTo:)` returned `true`.

     - Parameter model: The new value of the model.

     - Returns: The new item to be displayed in this section.
     */
    open func item(for model: Model) -> Item? {
        assertionFailure("item(for:) not implemented")
        return nil
    }

    /**
     The item currently displayed in the `UICollectionView`.
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `item` instead.
     */
    open var collectionViewItem: Item?

    /// The single item of this section.
    open var item: Item? {
        get { collectionViewItem }
        set {
            guard let context = context else {
                collectionViewItem = newValue
                return
            }
            if let sectionUpdate = calculateUpdate(from: collectionViewItem, to: newValue) {
                context.apply(update: sectionUpdate)
            }
        }
    }

    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data.
     
     - Parameter oldData: The old data currently displayed in the section.
     
     - Parameter newData: The new data that should be displayed in the section.
     
     - Returns: The update that should be performed on the section.
     */
    open func calculateUpdate(from oldData: Item?,
                              to newData: Item?) -> CollectionViewSectionUpdate<Item?>? {
        let changes: Set<CollectionViewSectionChange>
        switch (oldData, newData) {
        case (.some, .some):
            changes = [.reloadItem(at: 0)]

        case (.some, .none):
            changes = [.deleteItem(at: 0)]

        case (.none, .some):
            changes = [.insertItem(at: 0)]

        case (.none, .none):
            changes = []
        }
        return CollectionViewSectionUpdate(controller: self,
                                           changes: changes,
                                           data: newData,
                                           setData: { [weak self] in self?.collectionViewItem = $0 })
    }

    override open var numberOfItems: Int {
        return item != nil ? 1 : 0
    }
}
