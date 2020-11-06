import UIKit

/**
 A `CollectionViewAdapter` that contains a list of sections.

 - Note: Every call to `invalidateDataSource` and subsequent change of the `sections` property will result in a call to
 `reloadData()` on the underlying `UICollectionView`. If animated updates should occur, please
 override `calculateUpdate(from:to:)`.
 */
open class SingleSectionCollectionViewAdapter: NSObject, CollectionViewAdapter {
    /**
     Initialize an instance of `ListCollectionAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.

     - Parameter dataSource: The datasource of this adapter responsible for creating `SectionControllers`.
     */
    public init(viewController: UIViewController?,
                collectionView: UICollectionView,
                scrollViewDelegate: UIScrollViewDelegate? = nil,
                dataSource: SingleSectionCollectionViewAdapterDataSource? = nil) {
        let collectionContext = MainCollectionViewContext(viewController: viewController,
                                                          collectionView: collectionView)
        self.collectionContext = collectionContext
        self.scrollViewDelegate = scrollViewDelegate
        self.dataSource = dataSource
        super.init()
        collectionContext.sectionAdapter = self
        collectionView.dataSource = self
        collectionView.delegate = self
        if #available(iOS 11.0, *) {
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        }
        invalidateDataSource()
    }

    public let collectionContext: CollectionViewContext

    open weak var scrollViewDelegate: UIScrollViewDelegate?

    open weak var dataSource: SingleSectionCollectionViewAdapterDataSource? {
        didSet { invalidateDataSource() }
    }

    /**
     The single section currently displayed in the `UICollectionView`.

     - Warning: Only set this property inside an update block of `performBatchUpdates` and
     if `UICollectionView` insertions and deletions are handled, otherwise use `section` instead.
     */
    open var collectionViewSection: Section? = nil {
        willSet {
            collectionViewSection?.controller?.context = nil
        }
        didSet {
            collectionViewSection?.controller?.context = collectionContext
        }
    }

    /// The single section in the `UICollectionView`.
    open var section: Section? {
        get { collectionViewSection }
        set {
            if let newSection = newValue,
               let existingSection = collectionViewSection,
               existingSection.id == newSection.id,
               let existingController = existingSection.controller {
                newSection.controller = existingController
                existingController.didUpdate(model: newSection.model)
            }

            guard let update = calculateUpdate(from: collectionViewSection,
                                               to: newValue) else {
                collectionViewSection = newValue
                return
            }
            collectionContext.apply(update: update)
        }
    }

    open var sections: [Section] {
        guard let section = section else { return [] }
        return [section]
    }

    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data.

     - Parameter oldData: The old data currently displayed in the `UICollectionView`

     - Parameter newData: The new data that should be displayed in the `UICollectionView`

     - Returns: The update that should be performed on the `UICollectionView`
     */
    open func calculateUpdate(from oldData: Section?,
                              to newData: Section?) -> CollectionViewUpdate<Section?>? {
        let changes: Set<CollectionViewChange>
        switch (oldData, newData) {
        case let (.some(oldSection), .some(newSection)):
            // only check for id since we do not want to reload a section that already exists in the collection view
            // changes to the section will instead be handled by the sectioncontroller
            if oldSection.id == newSection.id {
                changes = []
            } else {
                changes = [.reloadSection(at: 0)]
            }

        case (.some, .none):
            changes = [.deleteSection(at: 0)]

        case (.none, .some):
            changes = [.insertSection(at: 0)]

        case (.none, .none):
            changes = []
        }
        return CollectionViewUpdate(changes: changes,
                                    data: newData,
                                    setData: { [weak self] in self?.collectionViewSection = $0 })
    }

    open func invalidateDataSource() {
        guard let dataSource = dataSource else { return }
        section = dataSource.section(for: self)
    }
}
