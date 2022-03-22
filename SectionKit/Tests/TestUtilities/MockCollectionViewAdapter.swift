@testable import SectionKit
import UIKit
import XCTest

internal final class MockCollectionViewAdapter: CollectionViewAdapter {
    // MARK: - context

    internal typealias ContextBlock = () -> CollectionViewContext

    internal lazy var _context: ContextBlock = {
        MockCollectionViewContext(
            collectionView: MockCollectionView(),
            errorHandler: MockErrorHandler()
        )
    }

    internal var context: CollectionViewContext { _context() }

    // MARK: - scrollViewDelegate

    internal typealias GetScrollViewDelegateBlock = () -> UIScrollViewDelegate?

    internal lazy var _scrollViewDelegate_get: GetScrollViewDelegateBlock = { nil }

    internal typealias SetScrollViewDelegateBlock = (UIScrollViewDelegate?) -> Void

    internal lazy var _scrollViewDelegate_set: SetScrollViewDelegateBlock = { _ in }

    internal var scrollViewDelegate: UIScrollViewDelegate? {
        get { _scrollViewDelegate_get() }
        set { _scrollViewDelegate_set(newValue) }
    }

    // MARK: - sections

    internal typealias SectionsBlock = () -> [Section]

    internal lazy var _sections: SectionsBlock = { [] }

    internal var sections: [Section] { _sections() }

    // MARK: - invalidateDataSource

    internal typealias InvalidateDataSourceBlock = () -> Void

    internal lazy var _invalidateDataSource: InvalidateDataSourceBlock = { }

    internal func invalidateDataSource() {
        _invalidateDataSource()
    }
}
