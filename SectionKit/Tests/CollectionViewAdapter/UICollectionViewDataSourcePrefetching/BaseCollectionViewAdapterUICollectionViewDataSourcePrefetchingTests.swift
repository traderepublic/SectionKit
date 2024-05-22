@testable import SectionKit
import UIKit
import XCTest

@available(iOS 10.0, *)
class BaseCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    func createCollectionView(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout? = nil
    ) -> UICollectionView {
        UICollectionView(frame: frame, collectionViewLayout: layout ?? UICollectionViewFlowLayout())
    }

    @MainActor
    func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDataSourcePrefetching {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testPrefetchItems() throws {
        let testExpectation = expectation(description: "Should invoke datasource prefetching delegate")
        let collectionView = createCollectionView()
        let itemsToPrefetch = [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)]
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSourcePrefetchingDelegate = {
                        let dataSourcePrefetchingDelegate = MockSectionDataSourcePrefetchingDelegate()
                        dataSourcePrefetchingDelegate._prefetchItems = { indexPaths, _ in
                            XCTAssertEqual(indexPaths.map(\.indexInCollectionView), itemsToPrefetch)
                            testExpectation.fulfill()
                        }
                        return dataSourcePrefetchingDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, prefetchItemsAt: itemsToPrefetch)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testPrefetchItemsWithInvalidIndices() throws {
        let testExpectation = expectation(description: "Should invoke datasource prefetching delegate")
        let collectionView = createCollectionView()
        let itemsToPrefetch = [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)]
        let invalidIndices = [IndexPath(), IndexPath(item: 0, section: 1)]
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSourcePrefetchingDelegate = {
                        let dataSourcePrefetchingDelegate = MockSectionDataSourcePrefetchingDelegate()
                        dataSourcePrefetchingDelegate._prefetchItems = { indexPaths, _ in
                            XCTAssertEqual(indexPaths.map(\.indexInCollectionView), itemsToPrefetch)
                            testExpectation.fulfill()
                        }
                        return dataSourcePrefetchingDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, prefetchItemsAt: itemsToPrefetch + invalidIndices)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCancelPrefetchingForItems() throws {
        let testExpectation = expectation(description: "Should invoke datasource prefetching delegate")
        let collectionView = createCollectionView()
        let itemsToCancel = [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)]
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSourcePrefetchingDelegate = {
                        let dataSourcePrefetchingDelegate = MockSectionDataSourcePrefetchingDelegate()
                        dataSourcePrefetchingDelegate._cancelPrefetchingForItems = { indexPaths, _ in
                            XCTAssertEqual(indexPaths.map(\.indexInCollectionView), itemsToCancel)
                            testExpectation.fulfill()
                        }
                        return dataSourcePrefetchingDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, cancelPrefetchingForItemsAt: itemsToCancel)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCancelPrefetchingForItemsWithInvalidIndices() throws {
        let testExpectation = expectation(description: "Should invoke datasource prefetching delegate")
        let collectionView = createCollectionView()
        let itemsToCancel = [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)]
        let invalidIndices = [IndexPath(), IndexPath(item: 0, section: 1)]
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSourcePrefetchingDelegate = {
                        let dataSourcePrefetchingDelegate = MockSectionDataSourcePrefetchingDelegate()
                        dataSourcePrefetchingDelegate._cancelPrefetchingForItems = { indexPaths, _ in
                            XCTAssertEqual(indexPaths.map(\.indexInCollectionView), itemsToCancel)
                            testExpectation.fulfill()
                        }
                        return dataSourcePrefetchingDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, cancelPrefetchingForItemsAt: itemsToCancel + invalidIndices)
        waitForExpectations(timeout: 1)
    }
}
