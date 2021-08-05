import SectionKit
import XCTest

@available(iOS 11.0, *)
internal class BaseSectionDragDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    internal func skipIfNeeded() throws {
        guard Self.self === BaseSectionDragDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func createSectionDragDelegate() throws -> SectionDragDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func testDragItemsForBeginning() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDragDelegate.dragItems(
            forBeginning: mockSession,
            at: indexPath,
            in: context
        ).isEmpty)
    }

    internal func testDragItemsForAdding() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
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

    internal func testDragSessionWillBegin() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        sectionDragDelegate.dragSessionWillBegin(
            mockSession,
            in: context
        )
    }

    internal func testDragSessionDidEnd() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        sectionDragDelegate.dragSessionDidEnd(
            mockSession,
            in: context
        )
    }

    internal func testDragPreviewParametersForItem() throws {
        let sectionDragDelegate = try createSectionDragDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
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
