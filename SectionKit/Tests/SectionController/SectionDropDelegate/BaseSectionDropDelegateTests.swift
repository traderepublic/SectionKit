import SectionKit
import XCTest

@available(iOS 11.0, *)
internal class BaseSectionDropDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    internal func skipIfNeeded() throws {
        guard Self.self === BaseSectionDropDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func createSectionDropDelegate() throws -> SectionDropDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func testCanHandle() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        XCTAssert(sectionDropDelegate.canHandle(
            drop: mockSession,
            in: context
        ))
    }

    internal func testDropSessionDidUpdate() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertEqual(
            sectionDropDelegate.dropSessionDidUpdate(
                mockSession,
                at: indexPath,
                in: context
            ).operation,
            .forbidden
        )
    }

    internal func testPerformDrop() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let coordinator = MockCollectionViewDropCoordinator()
        sectionDropDelegate.performDrop(
            at: indexPath,
            with: coordinator,
            in: context
        )
    }

    internal func testDropSessionDidEnter() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionDropDelegate.dropSessionDidEnter(
            mockSession,
            in: context
        )
    }

    internal func testDropSessionDidExit() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionDropDelegate.dropSessionDidExit(
            mockSession,
            in: context
        )
    }

    internal func testDropSessionDidEnd() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionDropDelegate.dropSessionDidEnd(
            mockSession,
            in: context
        )
    }

    internal func testDropPreviewParametersForItem() throws {
        let sectionDropDelegate = try createSectionDropDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionDropDelegate.dropPreviewParametersForItem(
            at: indexPath,
            in: context
        ))
    }
}

@available(iOS 11.0, *)
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

@available(iOS 11.0, *)
private final class MockCollectionViewDropCoordinator: NSObject, UICollectionViewDropCoordinator {
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

@available(iOS 11.0, *)
private final class MockDragAnimating: NSObject, UIDragAnimating {
    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}

@available(iOS 11.0, *)
private final class MockCollectionViewDropPlaceholderContext: NSObject, UICollectionViewDropPlaceholderContext {
    var dragItem: UIDragItem = .init(itemProvider: NSItemProvider(object: "" as NSString))

    func commitInsertion(dataSourceUpdates: (IndexPath) -> Void) -> Bool { false }

    func deletePlaceholder() -> Bool { false }

    func setNeedsCellUpdate() { }

    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}
