@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUICollectionViewDropDelegateTests: XCTestCase {
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
    ) throws -> CollectionViewAdapter & UICollectionViewDropDelegate {
        fatalError("not implemented")
    }

    // MARK: - canHandle

    internal func testCanHandleWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDropSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._canHandle = { session, _ in
                            XCTAssert(session === mockSession)
                            testExpectation.fulfill()
                            return true
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, canHandle: mockSession),
            true
        )
        waitForExpectations(timeout: 1)
    }

    internal func testCanHandleWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDropSession()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, canHandle: mockSession),
            false
        )
    }

    // MARK: - dropSessionDidUpdate

    internal func testDropSessionDidUpdateWithDestinationIndexPathAndWithInvalidIndex() throws {
        let testExpectation = expectation(description: "Should not invoke drop delegate")
        testExpectation.fulfill()
        let collectionView = createCollectionView()
        let mockSession = MockDropSession()
        let indexPath = IndexPath(item: 0, section: 1)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidUpdate = { _, _, _ in
                            testExpectation.fulfill()
                            return UICollectionViewDropProposal(operation: .copy)
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: indexPath
            ).operation,
            .forbidden
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropSessionDidUpdateWithDestinationIndexPathAndWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let collectionView = createCollectionView()
        let mockSession = MockDropSession()
        let proposal = UICollectionViewDropProposal(operation: .copy)
        let indexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidUpdate = { session, destinationIndexPath, _ in
                            XCTAssert(session === mockSession)
                            XCTAssertEqual(destinationIndexPath?.indexInCollectionView, indexPath)
                            testExpectation.fulfill()
                            return proposal
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
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: indexPath
            ) === proposal
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropSessionDidUpdateWithDestinationIndexPathAndWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let mockSession = MockDropSession()
        let indexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: indexPath
            ).operation,
            .forbidden
        )
    }

    internal func testDropSessionDidUpdateWithoutDestinationIndexPathAndWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._indexPathForItem = { _ in IndexPath(item: 0, section: 0) }
        let mockSession = MockDropSession()
        let proposal = UICollectionViewDropProposal(operation: .copy)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidUpdate = { session, destinationIndexPath, _ in
                            XCTAssert(session === mockSession)
                            XCTAssertNil(destinationIndexPath)
                            testExpectation.fulfill()
                            return proposal
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
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: nil
            ) === proposal
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropSessionDidUpdateWithoutDestinationIndexPathButInvalidLocation() throws {
        let testExpectation = expectation(description: "Should invoke indexPathForItem")
        let mockPoint = CGPoint(x: 1, y: 2)
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._indexPathForItem = { point in
            XCTAssertEqual(point, mockPoint)
            testExpectation.fulfill()
            return nil
        }
        let mockSession = MockDropSession()
        mockSession._location = { _ in mockPoint }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: nil
            ).operation,
            .forbidden
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropSessionDidUpdateWithoutDestinationIndexPathButLocationOfInvalidIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke indexPathForItem")
        let mockPoint = CGPoint(x: 1, y: 2)
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._indexPathForItem = { point in
            XCTAssertEqual(point, mockPoint)
            testExpectation.fulfill()
            return IndexPath(item: 0, section: 1)
        }
        let mockSession = MockDropSession()
        mockSession._location = { _ in mockPoint }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: nil
            ).operation,
            .forbidden
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropSessionDidUpdateWithoutDestinationIndexPathAndWithoutDelegate() throws {
        let testExpectation = expectation(description: "Should invoke indexPathForItem")
        let mockPoint = CGPoint(x: 1, y: 2)
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._indexPathForItem = { point in
            XCTAssertEqual(point, mockPoint)
            testExpectation.fulfill()
            return IndexPath(item: 0, section: 0)
        }
        let mockSession = MockDropSession()
        mockSession._location = { _ in mockPoint }
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                dropSessionDidUpdate: mockSession,
                withDestinationIndexPath: nil
            ).operation,
            .forbidden
        )
        waitForExpectations(timeout: 1)
    }

    // MARK: - performDrop

    internal func testPerformDropWithoutDestinationIndexPath() throws {
        let testExpectation = expectation(description: "Should not invoke drop delegate")
        testExpectation.fulfill()
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = nil
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropWithInvalidDestinationIndexPath() throws {
        let testExpectation = expectation(description: "Should not invoke drop delegate")
        testExpectation.fulfill()
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath()
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropWithUnknownDestinationIndexPath() throws {
        let testExpectation = expectation(description: "Should not invoke drop delegate")
        testExpectation.fulfill()
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath(item: 0, section: 1)
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropFromDifferentLocalSection() throws {
        let testExpectation = expectation(description: "Should not invoke drop delegate")
        testExpectation.fulfill()
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath(item: 0, section: 0)
        coordinator.items = [
            {
                let item = MockCollectionViewDropItem()
                item.sourceIndexPath = IndexPath(item: 1, section: 1)
                return item
            }()
        ]
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropFromSameLocalSection() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath(item: 0, section: 0)
        coordinator.items = [
            {
                let item = MockCollectionViewDropItem()
                item.sourceIndexPath = IndexPath(item: 1, section: 0)
                return item
            }()
        ]
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropFromRemote() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath(item: 0, section: 0)
        coordinator.items = [
            MockCollectionViewDropItem()
        ]
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._performDrop = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
        waitForExpectations(timeout: 1)
    }

    internal func testPerformDropWithoutDelegate() throws {
        let coordinator = MockCollectionViewDropCoordinator()
        coordinator.destinationIndexPath = IndexPath(item: 0, section: 0)
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView(collectionView, performDropWith: coordinator)
    }

    // MARK: - dropSessionDidEnter

    internal func testDropSessionDidEnter() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let mockSession = MockDropSession()
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidEnter = { session, _ in
                            XCTAssert(mockSession === session)
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, dropSessionDidEnter: mockSession)
        waitForExpectations(timeout: 1)
    }

    // MARK: - dropSessionDidExit

    internal func testDropSessionDidExit() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let mockSession = MockDropSession()
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidExit = { session, _ in
                            XCTAssert(mockSession === session)
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, dropSessionDidExit: mockSession)
        waitForExpectations(timeout: 1)
    }

    // MARK: - dropSessionDidEnd

    internal func testDropSessionDidEnd() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let mockSession = MockDropSession()
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropSessionDidEnd = { session, _ in
                            XCTAssert(mockSession === session)
                            testExpectation.fulfill()
                        }
                        return dropDelegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, dropSessionDidEnd: mockSession)
        waitForExpectations(timeout: 1)
    }

    // MARK: - dropPreviewParametersForItem

    internal func testDropPreviewParametersForItemWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke drop delegate")
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let mockPreviewParameters = UIDragPreviewParameters()
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = {
                        let dropDelegate = MockSectionDropDelegate()
                        dropDelegate._dropPreviewParametersForItem = { indexPath, _ in
                            XCTAssertEqual(indexPath.indexInCollectionView, itemIndexPath)
                            testExpectation.fulfill()
                            return mockPreviewParameters
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
                dropPreviewParametersForItemAt: itemIndexPath
            ) === mockPreviewParameters
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDropPreviewParametersForItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dropDelegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertNil(
            adapter.collectionView?(
                collectionView,
                dropPreviewParametersForItemAt: IndexPath(item: 0, section: 0)
            )
        )
    }
}

private class MockCollectionViewDropItem: NSObject, UICollectionViewDropItem {
    var dragItem = UIDragItem(itemProvider: NSItemProvider(object: NSString()))

    var sourceIndexPath: IndexPath?

    var previewSize: CGSize = .zero
}

private final class MockCollectionView: UICollectionView {
    typealias IndexPathForItemBlock = (CGPoint) -> IndexPath?

    var _indexPathForItem: IndexPathForItemBlock = { _ in nil }

    override func indexPathForItem(at point: CGPoint) -> IndexPath? {
        _indexPathForItem(point)
    }
}

private final class MockDropSession: NSObject, UIDropSession {
    var localDragSession: UIDragSession?

    var progressIndicatorStyle: UIDropSessionProgressIndicatorStyle = .default

    var items: [UIDragItem] = []

    var allowsMoveOperation: Bool = false

    var isRestrictedToDraggingApplication: Bool = true

    var progress: Progress { .init() }

    func loadObjects(ofClass aClass: NSItemProviderReading.Type, completion: @escaping ([NSItemProviderReading]) -> Void) -> Progress {
        .init()
    }

    func canLoadObjects(ofClass aClass: NSItemProviderReading.Type) -> Bool {
        false
    }

    lazy var _location: (UIView) -> CGPoint = { _ in .zero }

    func location(in view: UIView) -> CGPoint {
        _location(view)
    }

    func hasItemsConforming(toTypeIdentifiers typeIdentifiers: [String]) -> Bool {
        false
    }
}

private class MockCollectionViewDropCoordinator: NSObject, UICollectionViewDropCoordinator {
    var items: [UICollectionViewDropItem] = []

    var destinationIndexPath: IndexPath?

    var proposal: UICollectionViewDropProposal = .init(operation: .forbidden)

    var session: UIDropSession = MockDropSession()

    func drop(
        _ dragItem: UIDragItem,
        to placeholder: UICollectionViewDropPlaceholder
    ) -> UICollectionViewDropPlaceholderContext { MockCollectionViewDropPlaceholderContext() }

    func drop(
        _ dragItem: UIDragItem,
        toItemAt indexPath: IndexPath
    ) -> UIDragAnimating { MockDragAnimating() }

    func drop(
        _ dragItem: UIDragItem,
        intoItemAt indexPath: IndexPath,
        rect: CGRect
    ) -> UIDragAnimating { MockDragAnimating() }

    func drop(
        _ dragItem: UIDragItem,
        to target: UIDragPreviewTarget
    ) -> UIDragAnimating { MockDragAnimating() }
}

private class MockDragAnimating: NSObject, UIDragAnimating {
    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}

private class MockCollectionViewDropPlaceholderContext: NSObject, UICollectionViewDropPlaceholderContext {
    var dragItem: UIDragItem = .init(itemProvider: NSItemProvider(object: "" as NSString))

    func commitInsertion(dataSourceUpdates: (IndexPath) -> Void) -> Bool { false }

    func deletePlaceholder() -> Bool { false }

    func setNeedsCellUpdate() { }

    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}
