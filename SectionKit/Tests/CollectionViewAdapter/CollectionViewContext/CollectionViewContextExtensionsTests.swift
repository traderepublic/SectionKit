@testable import SectionKit
import XCTest

internal final class CollectionViewContextExtensionsTests: XCTestCase {
    // MARK: - dequeueReusableCell

    internal func testDequeueReusableCellForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableCell = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionViewCell()
        }
        let _: MockCollectionViewCell = context.dequeueReusableCell(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableCellForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableCell = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionViewCell()
        }
        let _ = context.dequeueReusableCell(MockCollectionViewCell.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableCellForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableCell = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionViewCell()
        }
        let _: MockCollectionViewCell = context.dequeueReusableCell(for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    // MARK: - dequeueReusableHeaderView

    internal func testDequeueReusableHeaderViewForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableHeaderView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableHeaderView(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableHeaderViewForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableHeaderView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _ = context.dequeueReusableHeaderView(MockCollectionReusableView.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableHeaderViewForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableHeaderView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableHeaderView(for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    // MARK: - dequeueReusableFooterView

    internal func testDequeueReusableFooterViewForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableFooterView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableFooterView(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableFooterViewForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableFooterView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _ = context.dequeueReusableFooterView(MockCollectionReusableView.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableFooterViewForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
        let context = MockCollectionViewContext(
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        context._dequeueReusableFooterView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableFooterView(for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }
}

private final class MockCollectionViewContext: CollectionViewContext {
    internal var viewController: UIViewController?

    internal var collectionView: UICollectionView

    internal var errorHandler: ErrorHandling

    internal init(
        viewController: UIViewController? = nil,
        collectionView: UICollectionView,
        errorHandler: ErrorHandling
    ) {
        self.viewController = viewController
        self.collectionView = collectionView
        self.errorHandler = errorHandler
    }

    internal func apply<T>(update: CollectionViewSectionUpdate<T>) { }

    internal func apply<T>(update: CollectionViewUpdate<T>) { }

    internal func sectionControllerWithAdjustedIndexPath(
        for indexPath: IndexPath
    ) -> (SectionController?, SectionIndexPath)? {
        nil
    }

    // MARK: - dequeueReusableCell

    internal typealias DequeueReusableCellBlock = (UICollectionViewCell.Type, IndexPath) -> UICollectionViewCell

    internal lazy var _dequeueReusableCell: DequeueReusableCellBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell where Cell : UICollectionViewCell {
        _dequeueReusableCell(cellType, indexPath) as! Cell
    }

    // MARK: - dequeueReusableHeaderView

    internal typealias DequeueReusableHeaderViewBlock = (UICollectionReusableView.Type, IndexPath) -> UICollectionReusableView

    internal lazy var _dequeueReusableHeaderView: DequeueReusableHeaderViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableHeaderView<SupplementaryView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView where SupplementaryView : UICollectionReusableView {
        _dequeueReusableHeaderView(viewType, indexPath) as! SupplementaryView
    }

    // MARK: - dequeueReusableFooterView

    internal typealias DequeueReusableFooterViewBlock = (UICollectionReusableView.Type, IndexPath) -> UICollectionReusableView

    internal lazy var _dequeueReusableFooterView: DequeueReusableFooterViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableFooterView<SupplementaryView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView where SupplementaryView : UICollectionReusableView {
        _dequeueReusableFooterView(viewType, indexPath) as! SupplementaryView
    }
}
