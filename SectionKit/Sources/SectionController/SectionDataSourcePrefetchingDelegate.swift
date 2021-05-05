import UIKit

/// The delegate for datasource prefetching.
@available(iOS 10.0, *)
public protocol SectionDataSourcePrefetchingDelegate: AnyObject {
    /**
     Tells the delegate to start prefetching items at the specified indexPaths.

     - Parameter indexPaths: The index paths of the items to be prefetched.
     */
    func prefetchItems(at indexPaths: [SectionIndexPath])

    /**
     Tells the delegate to cancel prefetching items at the specified indexPaths.

     - Parameter indexPaths: The index paths of the items that previously were considered as candidates
     for pre-fetching, but were not actually used.
     */
    func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath])
}

@available(iOS 10.0, *)
extension SectionDataSourcePrefetchingDelegate {
    public func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath]) { }
}
