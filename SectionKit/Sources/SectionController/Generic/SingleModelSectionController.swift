import UIKit

/**
 A `SectionController` that displays data of a single model. Unless overridden, `numberOfItems` will always be `1`
 and a change to its `model` will perform a call to `reloadItems(at:)`.

 This `SectionController` is typically used when there are one or multiple **different** cells from
 a single model. If however all items are the semantically similar and one could derive an array of models,
 it is recommended to use `ListSectionController` instead.

 - Warning: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
 */
open class SingleModelSectionController<Model>: BaseSectionController {
    /**
     Initialise an instance of `SingleModelSectionController`.

     - Parameter model: The model of this `SectionController`.
     */
    public init(model: Model) {
        self.collectionViewModel = model
        super.init()
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

    /**
     The model currently displayed in the `UICollectionView`.
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `model` instead.
     */
    open var collectionViewModel: Model

    /// The model of this `SectionController`.
    open var model: Model {
        get { collectionViewModel }
        set {
            guard let context = context else {
                collectionViewModel = newValue
                return
            }
            if let sectionUpdate = calculateUpdate(from: collectionViewModel, to: newValue) {
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
    open func calculateUpdate(
        from oldData: Model,
        to newData: Model
    ) -> CollectionViewSectionUpdate<Model>? {
        CollectionViewSectionUpdate(
            controller: self,
            data: newData,
            reloads: [0],
            setData: { self.collectionViewModel = $0 }
        )
    }

    override open func numberOfItems(in context: CollectionViewContext) -> Int { 1 }
}
