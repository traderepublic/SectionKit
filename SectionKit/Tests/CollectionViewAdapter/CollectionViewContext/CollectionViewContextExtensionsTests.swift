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
