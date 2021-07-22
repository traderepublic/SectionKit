import UIKit

/**
 A `CollectionViewAdapter` that contains a single section.
 */
open class SingleSectionCollectionViewAdapter: NSObject, CollectionViewAdapter {
    /**
     Initialize an instance of `SingleSectionCollectionViewAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter dataSource: The datasource of this adapter responsible for creating `SectionControllers`.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(
        viewController: UIViewController?,
        collectionView: UICollectionView,
        dataSource: SingleSectionCollectionViewAdapterDataSource?,
        scrollViewDelegate: UIScrollViewDelegate? = nil
    ) {
        let context = MainCollectionViewContext(
            viewController: viewController,
            collectionView: collectionView
        )
        self.context = context
        self.scrollViewDelegate = scrollViewDelegate
        self.dataSource = dataSource
        super.init()
        context.sectionAdapter = self
        collectionViewSection = dataSource?.section(for: self)
        collectionViewSection?.controller.context = context
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
     Initialize an instance of `SingleSectionCollectionViewAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter section: The single section to display in the `UICollectionView`.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(
        viewController: UIViewController?,
        collectionView: UICollectionView,
        section: Section? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil
    ) {
        let context = MainCollectionViewContext(
            viewController: viewController,
            collectionView: collectionView
        )
        self.context = context
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        context.sectionAdapter = self
        collectionViewSection = section
        collectionViewSection?.controller.context = context
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

    private var _errorHandler: ErrorHandling?

    /**
     The error handler of this adapter.

     If no custom error handler is set and self isn't implementing the `ErrorHandling` protocol,
     the default instance calls `assertionFailure` every time an error occurs.
     */
    open var errorHandler: ErrorHandling {
        get { _errorHandler ?? self as? ErrorHandling ?? AssertionFailureErrorHandler() }
        set { _errorHandler = newValue }
    }

    /**
     The single section currently displayed in the `UICollectionView`.

     - Warning: Only set this property inside an update block of `performBatchUpdates` and
     if `UICollectionView` insertions and deletions are handled, otherwise use `section` instead.
     */
    open var collectionViewSection: Section? = nil {
        willSet { collectionViewSection?.controller.context = nil }
        didSet { collectionViewSection?.controller.context = context }
    }

    /// The single section in the `UICollectionView`.
    open var section: Section? {
        get { collectionViewSection }
        set {
            if let new = newValue, let existing = collectionViewSection, existing.id == new.id {
                new.controller = existing.controller
                new.controller.didUpdate(model: new.model)
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
