@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUICollectionViewDragDelegateTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
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
    ) throws -> CollectionViewAdapter & UICollectionViewDragDelegate {
        fatalError("not implemented")
    }

    // MARK: - itemsForBeginning

    internal func testItemsForBeginningWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drag delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: NSString()))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = {
                        let dropDelegate = MockSectionDragDelegate()
                        dropDelegate._dragItemsForBeginning = { session, indexPath, _ in
                            XCTAssert(session === mockSession)
                            XCTAssertEqual(indexPath.indexInCollectionView, itemIndexPath)
                            testExpectation.fulfill()
                            return [dragItem]
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        let actual = adapter.collectionView(
            collectionView,
            itemsForBeginning: mockSession,
            at: itemIndexPath
        )
        XCTAssertEqual(actual.count, 1)
        XCTAssert(actual.first === dragItem)
        waitForExpectations(timeout: 1)
    }

    internal func testItemsForBeginningWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssert(adapter.collectionView(
            collectionView,
            itemsForBeginning: mockSession,
            at: itemIndexPath
        ).isEmpty)
    }

    // MARK: - itemsForAdding

    internal func testItemsForAddingWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drag delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let mockPoint = CGPoint(x: 1, y: 2)
        let dragItem = UIDragItem(itemProvider: NSItemProvider(object: NSString()))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = {
                        let dropDelegate = MockSectionDragDelegate()
                        dropDelegate._dragItemsForAdding = { session, indexPath, point, _ in
                            XCTAssert(session === mockSession)
                            XCTAssertEqual(indexPath.indexInCollectionView, itemIndexPath)
                            XCTAssertEqual(point, mockPoint)
                            testExpectation.fulfill()
                            return [dragItem]
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        let actual = adapter.collectionView?(
            collectionView,
            itemsForAddingTo: mockSession,
            at: itemIndexPath,
            point: mockPoint
        )
        XCTAssertEqual(actual?.count, 1)
        XCTAssert(actual?.first === dragItem)
        waitForExpectations(timeout: 1)
    }

    internal func testItemsForAddingWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let mockPoint = CGPoint(x: 1, y: 2)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                itemsForAddingTo: mockSession,
                at: itemIndexPath,
                point: mockPoint
            ).isEmpty,
            true
        )
    }

    // MARK: - dragPreviewParametersForItem

    internal func testDragPreviewParametersForItemWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drag delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let previewParameters = UIDragPreviewParameters()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = {
                        let dropDelegate = MockSectionDragDelegate()
                        dropDelegate._dragPreviewParametersForItem = { indexPath, _ in
                            XCTAssertEqual(indexPath.indexInCollectionView, itemIndexPath)
                            testExpectation.fulfill()
                            return previewParameters
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssert(
            adapter.collectionView?(
                collectionView,
                dragPreviewParametersForItemAt: itemIndexPath
            ) === previewParameters
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDragPreviewParametersForItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertNil(
            adapter.collectionView?(
                collectionView,
                dragPreviewParametersForItemAt: itemIndexPath
            )
        )
    }

    // MARK: - dragSessionWillBegin

    internal func testDragSessionWillBegin() throws {
        let testExpectation = expectation(description: "Should invoke drag delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = {
                        let dropDelegate = MockSectionDragDelegate()
                        dropDelegate._dragSessionWillBegin = { session, _ in
                            XCTAssert(session === mockSession)
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            dragSessionWillBegin: mockSession
        )
        waitForExpectations(timeout: 1)
    }

    // MARK: - dragSessionDidEnd

    internal func testDragSessionDidEnd() throws {
        let testExpectation = expectation(description: "Should invoke drag delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dragDelegate = {
                        let dropDelegate = MockSectionDragDelegate()
                        dropDelegate._dragSessionDidEnd = { session, _ in
                            XCTAssert(session === mockSession)
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            dragSessionDidEnd: mockSession
        )
        waitForExpectations(timeout: 1)
    }

    // MARK: - dragSessionAllowsMoveOperation

    internal func testDragSessionAllowsMoveOperation() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dragSessionAllowsMoveOperation: mockSession
            ),
            true
        )
    }

    // MARK: - dragSessionIsRestrictedToDraggingApplication

    internal func testDragSessionIsRestrictedToDraggingApplication() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDragSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dragSessionIsRestrictedToDraggingApplication: mockSession
            ),
            false
        )
    }
}

private final class MockDragSession: NSObject, UIDragSession {
    var localContext: Any?

    var items: [UIDragItem] = []

    var allowsMoveOperation = false

    var isRestrictedToDraggingApplication = false

    func location(in view: UIView) -> CGPoint {
        .zero
    }

    func hasItemsConforming(toTypeIdentifiers typeIdentifiers: [String]) -> Bool {
        false
    }

    func canLoadObjects(ofClass aClass: NSItemProviderReading.Type) -> Bool {
        false
    }
}
