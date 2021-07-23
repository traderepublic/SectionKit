import SectionKit
import UIKit
import XCTest

internal class MockSectionDataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate {
    // MARK: - prefetchItems

    internal typealias PrefetchItemsBlock = ([SectionIndexPath], CollectionViewContext) -> Void

    internal var _prefetchItems: PrefetchItemsBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func prefetchItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) {
        _prefetchItems(indexPaths, context)
    }

    // MARK: - cancelPrefetchingForItems

    internal typealias CancelPrefetchingForItemsBlock = ([SectionIndexPath], CollectionViewContext) -> Void

    internal var _cancelPrefetchingForItems: CancelPrefetchingForItemsBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func cancelPrefetchingForItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) {
        _cancelPrefetchingForItems(indexPaths, context)
    }
}
