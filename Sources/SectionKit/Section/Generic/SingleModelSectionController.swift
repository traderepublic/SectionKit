import UIKit

open class SingleModelSectionController<Model: SectionModel>: BaseSectionController {
    
    // MARK: - SectionController
    
    public init(model: Model) {
        self.collectionViewModel = model
        super.init()
    }
    
    override open func didUpdate(model: SectionModel) {
        guard let model = model as? Model else {
            assertionFailure("Could not cast model to \(String(describing: Model.self))")
            return
        }
        self.model = model
    }
    
    /**
     The model currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, otherwise use `model` instead.
     */
    open var collectionViewModel: Model
    
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
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the section
     
     - Parameter newData: The new data that should be displayed in the section
     
     - Returns: The update that should be performed on the section
     */
    open func calculateUpdate(from oldData: Model,
                              to newData: Model) -> SectionUpdate<Model>? {
        let changes: Set<SectionChange>
        if oldData.isEqual(to: newData) {
            changes = []
        } else {
            changes = [.reloadItem(at: 0)]
        }
        return SectionUpdate(sectionId: model.sectionId,
                             changes: changes,
                             data: newData,
                             setData: { [weak self] in self?.collectionViewModel = $0 })
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        return 1
    }
}
