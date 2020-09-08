import UIKit

open class ListCollectionViewAdapter: NSObject, CollectionViewAdapter {
    /**
     Initialize an instance of `ListCollectionAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.
     
     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.
     
     - Parameter collectionView: The `UICollectionView` to use to display the data.
     
     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(viewController: UIViewController?,
                collectionView: UICollectionView,
                scrollViewDelegate: UIScrollViewDelegate? = nil) {
        let collectionContext = MainCollectionViewContext(viewController: viewController,
                                                          collectionView: collectionView)
        self.collectionContext = collectionContext
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        collectionContext.sectionAdapter = self
        collectionView.dataSource = self
        collectionView.delegate = self
        if #available(iOS 11.0, *) {
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        }
    }

    public let collectionContext: CollectionViewContext

    open weak var scrollViewDelegate: UIScrollViewDelegate?

    open weak var dataSource: CollectionViewAdapterDataSource? {
        didSet { invalidateDataSource() }
    }

    /**
     The list of sections currently displayed in the `UICollectionView`.
     
     - Warning: Only set this property inside an update block of `performBatchUpdates` and
     if `UICollectionView` insertions and deletions are handled, otherwise use `sections` instead.
     */
    open var collectionViewSections: [Section] = [] {
        willSet {
            collectionViewSections.forEach { $0.controller.context = nil }
        }
        didSet {
            collectionViewSections.forEach { $0.controller.context = collectionContext }
        }
    }

    open var sections: [Section] {
        get { collectionViewSections }
        set {
            let collectionUpdate = calculateUpdate(from: collectionViewSections,
                                                   to: newValue)
            collectionContext.apply(update: collectionUpdate)
        }
    }

    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the `UICollectionView`
     
     - Parameter newData: The new data that should be displayed in the `UICollectionView`
     
     - Returns: The update that should be performed on the `UICollectionView`
     */
    open func calculateUpdate(from oldData: [Section],
                              to newData: [Section]) -> CollectionViewUpdate<[Section]> {
        return CollectionViewUpdate(data: newData, setData: { [weak self] in self?.collectionViewSections = $0 })
    }

    open var allowReorderingBetweenDifferentSections: Bool = false

    open func invalidateDataSource() {
        guard let dataSource = dataSource else { return }
        sections = querySections(from: dataSource)
    }

    private func querySections(from dataSource: CollectionViewAdapterDataSource) -> [Section] {
        var newSections: [Section] = []
        for model in dataSource.models(for: self) {
            let section: Section
            if let existingSection = sections.first(where: { $0.model.sectionId == model.sectionId }) {
                section = Section(model: model, controller: existingSection.controller)
                if !model.isEqual(to: existingSection.model) {
                    existingSection.controller.didUpdate(model: model)
                }
            } else {
                section = Section(model: model) { [unowned self] in
                    dataSource.sectionController(with: model, for: self)
                }
            }
            newSections.append(section)
        }
        return newSections
    }
}
