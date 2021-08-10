import UIKit

/**
 A `CollectionViewAdapter` that contains a single section.
 */
open class SingleSectionCollectionViewAdapter: NSObject, CollectionViewAdapter {
    /**
     Initialise an instance of `SingleSectionCollectionViewAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter dataSource: The datasource of this adapter responsible for creating `SectionControllers`.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(
        collectionView: UICollectionView,
        dataSource: SingleSectionCollectionViewAdapterDataSource,
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = ErrorHandler()
    ) {
        let context = MainCollectionViewContext(
            viewController: viewController,
            collectionView: collectionView,
            errorHandler: errorHandler
        )
        self.context = context
        self.scrollViewDelegate = scrollViewDelegate
        self.dataSource = dataSource
        super.init()
        context.adapter = self
        collectionViewSection = dataSource.section(for: self)
        collectionView.dataSource = self
        if #available(iOS 10.0, *) {
            collectionView.prefetchDataSource = self
            collectionView.isPrefetchingEnabled = true
        }
        collectionView.delegate = self
        if #available(iOS 11.0, *) {
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        }
    }

    /**
     Initialise an instance of `SingleSectionCollectionViewAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter section: The single section to display in the `UICollectionView`.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(
        collectionView: UICollectionView,
        section: Section? = nil,
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = ErrorHandler()
    ) {
        let context = MainCollectionViewContext(
            viewController: viewController,
            collectionView: collectionView,
            errorHandler: errorHandler
        )
        self.context = context
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        context.adapter = self
        collectionViewSection = section
        collectionView.dataSource = self
        if #available(iOS 10.0, *) {
            collectionView.prefetchDataSource = self
            collectionView.isPrefetchingEnabled = true
        }
        collectionView.delegate = self
        if #available(iOS 11.0, *) {
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
        }
    }

    public let context: CollectionViewContext

    open weak var scrollViewDelegate: UIScrollViewDelegate?

    open weak var dataSource: SingleSectionCollectionViewAdapterDataSource? {
        didSet { invalidateDataSource() }
    }

    private var _collectionViewSection: Section?

    /**
     The single section currently displayed in the `UICollectionView`.

     - Warning: Only set this property inside an update block of `performBatchUpdates` and
     if `UICollectionView` insertions and deletions are handled, otherwise use `section` instead.
     */
    open var collectionViewSection: Section? {
        get { _collectionViewSection }
        set {
            _collectionViewSection?.controller.context = nil
            _collectionViewSection = newValue
            newValue?.controller.context = context
        }
    }

    /// The single section in the `UICollectionView`.
    open var section: Section? {
        get { collectionViewSection }
        set {
            if let newSection = newValue, let existingSection = collectionViewSection, existingSection.id == newSection.id {
                let existingController = existingSection.controller
                newSection.controller = existingController
                existingController.didUpdate(model: newSection.model)
            }
            guard let update = calculateUpdate(from: collectionViewSection, to: newValue) else {
                collectionViewSection = newValue
                return
            }
            context.apply(update: update)
        }
    }

    open var sections: [Section] {
        guard let section = section else {
            return []
        }
        return [section]
    }

    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data.

     - Parameter oldData: The old data currently displayed in the `UICollectionView`

     - Parameter newData: The new data that should be displayed in the `UICollectionView`

     - Returns: The update that should be performed on the `UICollectionView`
     */
    open func calculateUpdate(
        from oldData: Section?,
        to newData: Section?
    ) -> CollectionViewUpdate<Section?>? {
        var deletes: Set<Int> = []
        var inserts: Set<Int> = []
        var reloads: Set<Int> = []
        switch (oldData, newData) {
        case let (.some(oldSection), .some(newSection)):
            // only check for id since we do not want to reload a section that already exists in the collection view
            // changes to the section will instead be handled by the sectioncontroller
            if oldSection.id != newSection.id {
                reloads = [0]
            }

        case (.some, .none):
            deletes = [0]

        case (.none, .some):
            inserts = [0]

        case (.none, .none):
            break
        }
        return CollectionViewUpdate(
            data: newData,
            deletes: deletes,
            inserts: inserts,
            reloads: reloads,
            setData: { self.collectionViewSection = $0 }
        )
    }

    open func invalidateDataSource() {
        guard let dataSource = dataSource else {
            return
        }
        section = dataSource.section(for: self)
    }
}
