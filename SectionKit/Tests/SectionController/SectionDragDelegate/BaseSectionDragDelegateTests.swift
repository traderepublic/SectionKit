import SectionKit
import XCTest

@available(iOS 11.0, *)
class BaseSectionDragDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseSectionDragDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func createSectionDragDelegate() throws -> SectionDragDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testDragItemsForBeginning() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let mockSession = MockDragSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDragDelegate.dragItems(
            forBeginning: mockSession,
            at: indexPath,
            in: context
        ).isEmpty)
    }

    @MainActor
    func testDragItemsForAdding() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let mockSession = MockDragSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDragDelegate.dragItems(
            forAddingTo: mockSession,
            at: indexPath,
            point: .zero,
            in: context
        ).isEmpty)
    }

    @MainActor
    func testDragSessionWillBegin() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let mockSession = MockDragSession()
        sectionDragDelegate.dragSessionWillBegin(
            mockSession,
            in: context
        )
    }

    @MainActor
    func testDragSessionDidEnd() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let mockSession = MockDragSession()
        sectionDragDelegate.dragSessionDidEnd(
            mockSession,
            in: context
        )
    }

    @MainActor
    func testDragPreviewParametersForItem() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionDragDelegate.dragPreviewParametersForItem(
            at: indexPath,
            in: context
        ))
    }
}

@available(iOS 11.0, *)
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
