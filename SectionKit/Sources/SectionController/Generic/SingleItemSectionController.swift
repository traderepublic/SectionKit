import UIKit

/**
 A `SectionController` that displays a single item derived of a single model.

 This `SectionController` is typically used when one item should be displayed conditionally.
 If however multiple items should be displayed, it is recommended to use `ListSectionController` instead.

 - Warning: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
 */
open class SingleItemSectionController<Model, Item>: BaseSectionController {
    private let areItemsEqual: (Item, Item) -> Bool

    /**
     Initialize an instance of `SingleItemSectionController`.

     - Parameter model: The model of this `SectionController`.
     */
    public init(model: Model, areItemsEqual: @escaping (Item, Item) -> Bool) {
        self.model = model
        self.areItemsEqual = areItemsEqual
        super.init()
        if shouldUpdateItem(afterModelChangedTo: model) {
            item = item(for: model)
        }
    }

    override open func didUpdate(model: Any) {
        guard let model = model as? Model else {
            context?.errorHandler(
                error: .sectionControllerModelTypeMismatch(
                    expected: Model.self,
                    actual: type(of: model)
                )
            )
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
    open func shouldUpdateItem(afterModelChangedTo model: Model) -> Bool { true }

    /**
     Derives the item from the given `Model`.

     Will be called automatically if `shouldUpdateItem(afterModelChangedTo:)` returned `true`.

     - Parameter model: The new value of the model.

     - Returns: The new item to be displayed in this section.
     */
    open func item(for model: Model) -> Item? {
        context?.errorHandler(error: .notImplemented())
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
    open func calculateUpdate(from oldData: Item?, to newData: Item?) -> CollectionViewSectionUpdate<Item?>? {
        var deletes: Set<Int> = []
        var inserts: Set<Int> = []
        var reloads: Set<Int> = []
        switch (oldData, newData) {
        case let (.some(oldItem), .some(newItem)):
            reloads = areItemsEqual(oldItem, newItem) ? [] : [0]

        case (.some, .none):
            deletes = [0]

        case (.none, .some):
            inserts = [0]

        case (.none, .none):
            break
        }
        return CollectionViewSectionUpdate(
            controller: self,
            data: newData,
            deletes: deletes,
            inserts: inserts,
            reloads: reloads,
            setData: { self.collectionViewItem = $0 }
        )
    }

    override open func numberOfItems(in context: CollectionViewContext) -> Int { item != nil ? 1 : 0 }
}

extension SingleItemSectionController where Item: Equatable {
    /**
     Initialize an instance of `SingleItemSectionController`
     which will only reload when the new item is different from the old one.

     - Parameter model: The model of this `SectionController`.
     */
    public convenience init(model: Model) {
        self.init(model: model, areItemsEqual: ==)
    }
}
