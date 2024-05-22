@testable import SectionKit
import XCTest

final class CollectionViewContextExtensionsTests: XCTestCase {
    private var context: MockCollectionViewContext!

    @MainActor
    override func setUp() {
        super.setUp()
        context = MockCollectionViewContext(
            collectionView: UICollectionView(
                frame: .zero,
                collectionViewLayout: UICollectionViewFlowLayout()
            ),
            errorHandler: MockErrorHandler()
        )
    }

    override func tearDown() {
        context = nil
        super.tearDown()
    }

    // MARK: - dequeueReusableCell

    @MainActor
    func testDequeueReusableCellForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
        context._dequeueReusableCell = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionViewCell()
        }
        let _: MockCollectionViewCell = context.dequeueReusableCell(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableCellForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
        context._dequeueReusableCell = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionViewCell()
        }
        let _ = context.dequeueReusableCell(MockCollectionViewCell.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableCellForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableCell")
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

    @MainActor
    func testDequeueReusableHeaderViewForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
        context._dequeueReusableHeaderView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableHeaderView(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableHeaderViewForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
        context._dequeueReusableHeaderView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _ = context.dequeueReusableHeaderView(MockCollectionReusableView.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableHeaderViewForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableHeaderView")
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

    @MainActor
    func testDequeueReusableFooterViewForIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
        context._dequeueReusableFooterView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _: MockCollectionReusableView = context.dequeueReusableFooterView(for: IndexPath(item: 0, section: 0))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableFooterViewForSectionIndexPathWithExplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
        context._dequeueReusableFooterView = { cellType, indexPath in
            XCTAssert(cellType === MockCollectionReusableView.self)
            XCTAssertEqual(indexPath, IndexPath(item: 0, section: 0))
            testExpectation.fulfill()
            return MockCollectionReusableView()
        }
        let _ = context.dequeueReusableFooterView(MockCollectionReusableView.self, for: SectionIndexPath(IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDequeueReusableFooterViewForSectionIndexPathWithImplicitType() {
        let testExpectation = expectation(description: "Should invoke dequeueReusableFooterView")
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
