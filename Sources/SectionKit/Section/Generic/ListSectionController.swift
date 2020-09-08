import UIKit

/**
 A `SectionController` that handles a list of items.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed.
 */
open class ListSectionController<Model: SectionModel, Item>: BaseSectionController {
    /**
     Initialize an instance of `ListSectionController`.

     - Parameter model: The model of this `SectionController`.
     */
    public init(model: Model) {
        self.model = model
        super.init()
        if shouldUpdateItems(afterModelChangedTo: model) {
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

    /// The model of this `SectionController`.
    open var model: Model {
        didSet {
            if shouldUpdateItems(afterModelChangedTo: model) {
                items = items(for: model)
            }
        }
    }

    /**
     Determines if the list of items should be updated after the model was updated to a new value.

     The default value is `true`.

     - Parameter model: The new value of the model.

     - Returns: If the list of items should be updated after the model was updated to a new value.
     */
    open func shouldUpdateItems(afterModelChangedTo model: Model) -> Bool {
        return true
    }

    /**
     Derives a list of items from the given `Model`.

     Will be called automatically if `shouldUpdateItems(afterModelChangedTo:)` returned `true`.

     - Parameter model: The new value of the model.

     - Returns: The new items to be displayed in this section.
     */
    open func items(for model: Model) -> [Item] {
        assertionFailure("items(for:) not implemented")
        return []
    }

    /**
     The list of items currently displayed in the `UICollectionView`.
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `items` instead.
     */
    open var collectionViewItems: [Item] = []

    /// The items of this section.
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
     Calculate the `UICollectionView` events using the difference from the old to the new data.
     
     - Parameter oldData: The old data currently displayed in the section.
     
     - Parameter newData: The new data that should be displayed in the section.
     
     - Returns: The update that should be performed on the section.
     */
    open func calculateUpdate(from oldData: [Item],
                              to newData: [Item]) -> CollectionViewSectionUpdate<[Item]>? {
        return CollectionViewSectionUpdate(sectionId: model.sectionId,
                                           data: newData,
                                           setData: { [weak self] in self?.collectionViewItems = $0 })
    }

    override open var numberOfItems: Int {
        return items.count
    }
}
