import UIKit

/// The root object for a given `UICollectionView` that forwards datasource and delegate methods to the corresponding `SectionController`
open class ListSectionAdapter: NSObject {
    
    // MARK: - Properties
    
    public let collectionContext: CollectionContext
    
    open weak var scrollViewDelegate: UIScrollViewDelegate?
    
    /**
     The list of sections currently displayed in the `UICollectionView`
     
     Only set this property if `UICollectionView` insertions and deletions are handled, use `sectionControllers` instead.
     */
    open var collectionViewSectionControllers: [SectionController] {
        willSet {
            collectionViewSectionControllers.forEach { $0.context = nil }
        }
        didSet {
            collectionViewSectionControllers.forEach { $0.context = collectionContext }
        }
    }
    
    open var sectionControllers: [SectionController] {
        get { collectionViewSectionControllers }
        set {
            let collectionUpdate = calculateUpdate(from: collectionViewSectionControllers,
                                                   to: newValue)
            collectionContext.apply(update: collectionUpdate)
        }
    }
    
    internal var cachedIndexTitles: [(sectionControllerId: String, title: String)] = []
    
    open var allowReorderingBetweenDifferentSections: Bool = false
    
    // MARK: - Initializer
    
    /**
     Initialize an instance of `SectionAdapter` to use it as the datasource and delegate of the given `UICollectionView`
     
     Make sure to set up all your `SectionController`s before initializing the corresponding `SectionAdapter`
     
     - Parameter viewController: The `UIViewController` which owns the `UICollectionView` and will be used in the `CollectionContext`
     
     - Parameter collectionView: The `UICollectionView` to use to display the data
     
     - Parameter sectionControllers: The list of `SectionController` of which every controller handles a single section in the `UICollectionView`
     
     - Parameter scrollViewDelegate: An optional delegate instance that should receive `UIScrollViewDelegate` callbacks
     */
    public init(viewController: UIViewController,
                collectionView: UICollectionView,
                sectionControllers: [SectionController] = [],
                scrollViewDelegate: UIScrollViewDelegate? = nil) {
        let collectionContext = MainCollectionContext(viewController: viewController, collectionView: collectionView)
        self.collectionContext = collectionContext
        self.collectionViewSectionControllers = sectionControllers
        sectionControllers.forEach { $0.context = collectionContext }
        self.scrollViewDelegate = scrollViewDelegate
        super.init()
        collectionContext.sectionControllers = { [weak self] in
            self?.sectionControllers ?? []
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        if #available(iOS 11.0, *) {
            collectionView.dragDelegate = self
            collectionView.dropDelegate = self
            collectionView.dragInteractionEnabled = true
        }
    }
    
    // MARK: - Helper functions
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the `UICollectionView`
     
     - Parameter newData: The new data that should be displayed in the `UICollectionView`
     
     - Returns: The update that should be performed on the `UICollectionView`
     */
    open func calculateUpdate(from oldData: [SectionController],
                              to newData: [SectionController]) -> CollectionUpdate<[SectionController]> {
        return CollectionUpdate(data: newData,
                                setData: { [weak self] in self?.collectionViewSectionControllers = $0 })
    }
}

