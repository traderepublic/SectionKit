@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUIScrollViewDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    internal func skipIfNeeded() throws {
        guard Self.self === BaseCollectionViewAdapterUIScrollViewDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func createCollectionView(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()
    ) -> UICollectionView {
        UICollectionView(frame: frame, collectionViewLayout: layout)
    }

    internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = AssertionFailureErrorHandler()
    ) throws -> CollectionViewAdapter & UIScrollViewDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func testScrollViewDidScroll() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidScroll = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidScroll?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidZoom() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidZoom = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidZoom?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewWillBeginDragging() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewWillBeginDragging = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewWillBeginDragging?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewWillEndDragging() throws {
        let velocity = CGPoint(x: 1, y: 2)
        let targetContentOffset = CGPoint(x: 4, y: 8)
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewWillEndDragging = {
            XCTAssert($0 === collectionView)
            XCTAssertEqual($1, velocity)
            XCTAssertEqual($2.pointee, targetContentOffset)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        var offset = targetContentOffset
        adapter.scrollViewWillEndDragging?(
            collectionView,
            withVelocity: velocity,
            targetContentOffset: &offset
        )
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidEndDragging() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidEndDragging = { scrollView, decelerate in
            XCTAssert(scrollView === collectionView)
            XCTAssert(decelerate)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidEndDragging?(collectionView, willDecelerate: true)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewWillBeginDecelerating() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewWillBeginDecelerating = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewWillBeginDecelerating?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidEndDecelerating() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidEndDecelerating = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidEndDecelerating?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidEndScrollingAnimation() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidEndScrollingAnimation = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidEndScrollingAnimation?(collectionView)
        waitForExpectations(timeout: 1)
    }

    internal func testViewForZooming() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        let view = UIView()
        scrollViewDelegate._viewForZooming = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
            return view
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssert(adapter.viewForZooming?(in: collectionView) === view)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewWillBeginZooming() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        let view = UIView()
        scrollViewDelegate._scrollViewWillBeginZooming = {
            XCTAssert($0 === collectionView)
            XCTAssert($1 === view)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewWillBeginZooming?(collectionView, with: view)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidEndZooming() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        let view = UIView()
        scrollViewDelegate._scrollViewDidEndZooming = {
            XCTAssert($0 === collectionView)
            XCTAssert($1 === view)
            XCTAssertEqual($2, 1)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidEndZooming?(collectionView, with: view, atScale: 1)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewShouldScrollToTop() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewShouldScrollToTop = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
            return true
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssertEqual(adapter.scrollViewShouldScrollToTop?(collectionView), true)
        waitForExpectations(timeout: 1)
    }

    internal func testScrollViewDidScrollToTop() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidScrollToTop = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidScrollToTop?(collectionView)
        waitForExpectations(timeout: 1)
    }

    @available(iOS 11.0, *)
    internal func testScrollViewDidChangeAdjustedContentInset() throws {
        let testExpectation = expectation(description: "Should invoke scroll delegate")
        let collectionView = createCollectionView()
        let scrollViewDelegate = MockScrollViewDelegate()
        scrollViewDelegate._scrollViewDidChangeAdjustedContentInset = { scrollView in
            XCTAssert(scrollView === collectionView)
            testExpectation.fulfill()
        }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: scrollViewDelegate
        )
        adapter.scrollViewDidChangeAdjustedContentInset?(collectionView)
        waitForExpectations(timeout: 1)
    }
}
