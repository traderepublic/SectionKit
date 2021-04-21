import UIKit

/**
 A `CollectionViewAdapter` that contains a list of sections.

 - Note: Every call to `invalidateDataSource` and subsequent change of the `sections` property will result in a call to
 `reloadData()` on the underlying `UICollectionView`. If animated updates should occur, please
 override `calculateUpdate(from:to:)`.
 */
open class ListCollectionViewAdapter: NSObject, CollectionViewAdapter {
    /**
     Initialize an instance of `ListCollectionAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.
     
     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.
     
     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter dataSource: The datasource of this adapter responsible for creating `SectionControllers`.
     
     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(viewController: UIViewController?,
                collectionView: UICollectionView,
                dataSource: ListCollectionViewAdapterDataSource?,
                scrollViewDelegate: UIScrollViewDelegate? = nil) {
        let collectionContext = MainCollectionViewContext(viewController: viewController,
                                                          collectionView: collectionView)
        self.collectionContext = collectionContext
        self.scrollViewDelegate = scrollViewDelegate
        self.dataSource = dataSource
        super.init()
        collectionContext.sectionAdapter = self
        collectionViewSections = dataSource?.sections(for: self) ?? []
        collectionViewSections.forEach { $0.controller.context = collectionContext }
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
     Initialize an instance of `ListCollectionAdapter` to use it as the datasource and
     delegate of the given `UICollectionView`.

     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`.

     - Parameter collectionView: The `UICollectionView` to use to display the data.

     - Parameter sections: The sections to display in the `UICollectionView`.

     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks.
     */
    public init(viewController: UIViewController?,
                collectionView: UICollectionView,
                sections: [Section] = [],
                scrollViewDelegate: UIScrollViewDelegate? = nil) {
        let collectionContext = MainCollectionViewContext(viewController: viewController,
                                                          collectionView: collectionView)
        self.collectionContext = collectionContext
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        collectionContext.sectionAdapter = self
        collectionViewSections = sections
        collectionViewSections.forEach { $0.controller.context = collectionContext }
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

    public let collectionContext: CollectionViewContext

    open weak var scrollViewDelegate: UIScrollViewDelegate?

    open weak var dataSource: ListCollectionViewAdapterDataSource? {
        didSet { invalidateDataSource() }
    }

    private var _collectionViewSections: [Section] = []

    /**
     The list of sections currently displayed in the `UICollectionView`.
     
     - Warning: Only set this property inside an update block of `performBatchUpdates` and
     if `UICollectionView` insertions and deletions are handled, otherwise use `sections` instead.
     */
    open var collectionViewSections: [Section] {
        get {
            return _collectionViewSections
        }

        set {
            let uniqueSections = checkOrFilterDuplicateSectionIds(sections: newValue)
            _collectionViewSections.forEach { $0.controller.context = nil }
            _collectionViewSections = uniqueSections
            uniqueSections.forEach { $0.controller.context = collectionContext }
        }
    }

    /// Check for duplicate section IDs and fail gracefully if some are found.
    /// For debug builds, crash if the section IDs are not unique.
    /// For production builds, remove sections with duplicate IDs.
    /// - Parameter sections: The collectionview sections that have just been set by the user
    /// - Returns: The same sections with additional duplicates removed. Only the first section with
    ///            a duplicate ID is kept.
    private func checkOrFilterDuplicateSectionIds(sections: [Section]) -> [Section] {
        let filtered = sections.unique(by: \.id)
        assert(
            filtered.count == sections.count,
            """
               The list of sections contains two or more sections with the same id.
               This would result in undefined behaviour.
            """
        )
        return filtered
    }

    open var sections: [Section] {
        get { collectionViewSections }
        set {
            for newSection in newValue {
                guard let existingSection = collectionViewSections.first(where: { $0.id == newSection.id }) else {
                    continue
                }
                newSection.controller = existingSection.controller
                newSection.controller.didUpdate(model: newSection.model)
            }

            guard let update = calculateUpdate(from: collectionViewSections, to: newValue) else {
                collectionViewSections = newValue
                return
            }
            collectionContext.apply(update: update)
        }
    }

    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data.
     
     - Parameter oldData: The old data currently displayed in the `UICollectionView`
     
     - Parameter newData: The new data that should be displayed in the `UICollectionView`
     
     - Returns: The update that should be performed on the `UICollectionView`
     */
    open func calculateUpdate(from oldData: [Section],
                              to newData: [Section]) -> CollectionViewUpdate<[Section]>? {
        return CollectionViewUpdate(data: newData, setData: { [weak self] in self?.collectionViewSections = $0 })
    }

    open func invalidateDataSource() {
        guard let dataSource = dataSource else { return }
        sections = dataSource.sections(for: self)
    }
}
