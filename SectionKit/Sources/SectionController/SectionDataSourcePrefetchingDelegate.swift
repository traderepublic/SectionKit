import UIKit

/// The delegate for datasource prefetching.
@available(iOS 10.0, *)
@MainActor
public protocol SectionDataSourcePrefetchingDelegate: AnyObject {
    /**
     Tells the delegate to start prefetching items at the specified indexPaths.

     - Parameter indexPaths: The index paths of the items to be prefetched.

     - Parameter context: The context the prefetching datasource is contained in.
     */
    func prefetchItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext)

    /**
     Tells the delegate to cancel prefetching items at the specified indexPaths.

     - Parameter indexPaths: The index paths of the items that previously were considered as candidates
     for pre-fetching, but were not actually used.

     - Parameter context: The context the prefetching datasource is contained in.
     */
    func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext)
}

@available(iOS 10.0, *)
extension SectionDataSourcePrefetchingDelegate {
    public func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) { }
}
