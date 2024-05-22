import SectionKit
import XCTest

class BaseSectionDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseSectionDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func createSectionDelegate() throws -> SectionDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testShouldHighlightItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDelegate.shouldHighlightItem(at: indexPath, in: context))
    }

    @MainActor
    func testDidHighlightItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didHighlightItem(at: indexPath, in: context)
    }

    @MainActor
    func testDidUnhighlightItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didUnhighlightItem(at: indexPath, in: context)
    }

    @MainActor
    func testShouldSelectItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDelegate.shouldSelectItem(at: indexPath, in: context))
    }

    @MainActor
    func testShouldDeselectItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionDelegate.shouldDeselectItem(at: indexPath, in: context))
    }

    @MainActor
    func testDidSelectItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didSelectItem(at: indexPath, in: context)
    }

    @MainActor
    func testDidDeselectItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didDeselectItem(at: indexPath, in: context)
    }

    @MainActor
    func testWillDisplayCell() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.willDisplay(
            cell: UICollectionViewCell(),
            at: indexPath,
            in: context
        )
    }

    @MainActor
    func testWillDisplayHeaderView() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.willDisplay(
            headerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    @MainActor
    func testWillDisplayFooterView() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.willDisplay(
            footerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    @MainActor
    func testDidEndDisplayingCell() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didEndDisplaying(
            cell: UICollectionViewCell(),
            at: indexPath,
            in: context
        )
    }

    @MainActor
    func testDidEndDisplayingHeaderView() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didEndDisplaying(
            headerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    @MainActor
    func testDidEndDisplayingFooterView() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didEndDisplaying(
            footerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testShouldShowMenuForItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionDelegate.shouldShowMenuForItem(
            at: indexPath,
            in: context
        ))
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testCanPerform() throws {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionDelegate.canPerform(
            action: #selector(Mock.perform),
            forItemAt: indexPath,
            withSender: mockSender,
            in: context
        ))
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testPerform() throws {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.perform(
            action: #selector(Mock.perform),
            forItemAt: indexPath,
            withSender: mockSender,
            in: context
        )
    }

    @MainActor
    func testCanFocusItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertEqual(
            sectionDelegate.canFocusItem(
                at: indexPath,
                in: context
            ),
            sectionDelegate.shouldSelectItem(
                at: indexPath,
                in: context
            )
        )
    }

    @MainActor
    @available(iOS 11.0, *)
    func testShouldSpringLoadItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let interactionContext = MockSpringLoadedInteractionContext()
        XCTAssert(sectionDelegate.shouldSpringLoadItem(
            at: indexPath,
            with: interactionContext,
            in: context
        ))
    }

    @MainActor
    @available(iOS 13.0, *)
    func testShouldBeginMultipleSelectionInteraction() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionDelegate.shouldBeginMultipleSelectionInteraction(
            at: indexPath,
            in: context
        ))
    }

    @MainActor
    @available(iOS 13.0, *)
    func testDidBeginMultipleSelectionInteraction() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDelegate.didBeginMultipleSelectionInteraction(
            at: indexPath,
            in: context
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testContextMenuConfigurationForItem() throws {
        let sectionDelegate = try createSectionDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionDelegate.contextMenuConfigurationForItem(
            at: indexPath,
            point: .zero,
            in: context
        ))
    }
}

@available(iOS 11.0, *)
private final class MockSpringLoadedInteractionContext: NSObject, UISpringLoadedInteractionContext {
    var state: UISpringLoadedInteractionEffectState = .activated

    var targetView: UIView?

    var targetItem: Any?

    func location(in view: UIView?) -> CGPoint {
        .zero
    }
}
