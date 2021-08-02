import SectionKit
import XCTest

internal final class BaseSectionControllerTests: XCTestCase {
    // MARK: - SectionController

    internal func testContextIsNil() {
        let sectionController = BaseSectionController()
        XCTAssertNil(sectionController.context)
    }

    internal func testDataSourceIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dataSource === sectionController)
    }

    internal func testDataSourcePrefetchingDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dataSourcePrefetchingDelegate === sectionController)
    }

    internal func testDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.delegate === sectionController)
    }

    internal func testFlowDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.flowDelegate === sectionController)
    }

    internal func testDragDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dragDelegate === sectionController)
    }

    internal func testDropDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dropDelegate === sectionController)
    }

    internal func testDidUpdateModelDoesNothing() {
        let sectionController = BaseSectionController()
        sectionController.didUpdate(model: "")
    }

    // MARK: - SectionDataSource

    internal func testNumberOfItems() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        XCTAssertEqual(sectionController.numberOfItems(in: context), 0)
    }

    internal func testCellForItem() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionController.cellForItem(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionViewCell.self)
        waitForExpectations(timeout: 1)
    }

    internal func testHeaderView() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionController.headerView(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionReusableView.self)
        waitForExpectations(timeout: 1)
    }

    internal func testFooterView() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionController.footerView(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionReusableView.self)
        waitForExpectations(timeout: 1)
    }

    internal func testCanMoveItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionController.canMoveItem(at: indexPath, in: context))
    }

    internal func testMoveItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let sourceIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let destinationIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.moveItem(at: sourceIndexPath, to: destinationIndexPath, in: context)
    }

    // MARK: - SectionDataSourcePrefetchingDelegate

    internal func testPrefetchItems() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        sectionController.prefetchItems(at: [], in: context)
    }

    internal func testCancelPrefetchingForItems() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        sectionController.cancelPrefetchingForItems(at: [], in: context)
    }

    // MARK: - SectionDelegate

    internal func testShouldHighlightItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionController.shouldHighlightItem(at: indexPath, in: context))
    }

    internal func testDidHighlightItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didHighlightItem(at: indexPath, in: context)
    }

    internal func testDidUnhighlightItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didUnhighlightItem(at: indexPath, in: context)
    }

    internal func testShouldSelectItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionController.shouldSelectItem(at: indexPath, in: context))
    }

    internal func testShouldDeselectItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionController.shouldDeselectItem(at: indexPath, in: context))
    }

    internal func testDidSelectItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didSelectItem(at: indexPath, in: context)
    }

    internal func testDidDeselectItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didDeselectItem(at: indexPath, in: context)
    }

    internal func testWillDisplayCell() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.willDisplay(
            cell: UICollectionViewCell(),
            at: indexPath,
            in: context
        )
    }

    internal func testWillDisplayHeaderView() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.willDisplay(
            headerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    internal func testWillDisplayFooterView() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.willDisplay(
            footerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    internal func testDidEndDisplayingCell() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didEndDisplaying(
            cell: UICollectionViewCell(),
            at: indexPath,
            in: context
        )
    }

    internal func testDidEndDisplayingHeaderView() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didEndDisplaying(
            headerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    internal func testDidEndDisplayingFooterView() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didEndDisplaying(
            footerView: UICollectionReusableView(),
            at: indexPath,
            in: context
        )
    }

    // availability attribute is needed because of deprecation warning
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testShouldShowMenuForItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionController.shouldShowMenuForItem(
            at: indexPath,
            in: context
        ))
    }

    // availability attribute is needed because of deprecation warning
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testCanPerform() {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionController.canPerform(
            action: #selector(Mock.perform),
            forItemAt: indexPath,
            withSender: mockSender,
            in: context
        ))
    }

    // availability attribute is needed because of deprecation warning
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testPerform() {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.perform(
            action: #selector(Mock.perform),
            forItemAt: indexPath,
            withSender: mockSender,
            in: context
        )
    }

    internal func testCanFocusItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertEqual(
            sectionController.canFocusItem(
                at: indexPath,
                in: context
            ),
            sectionController.shouldSelectItem(
                at: indexPath,
                in: context
            )
        )
    }

    internal func testShouldSpringLoadItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let interactionContext = MockSpringLoadedInteractionContext()
        XCTAssert(sectionController.shouldSpringLoadItem(
            at: indexPath,
            with: interactionContext,
            in: context
        ))
    }

    internal func testShouldBeginMultipleSelectionInteraction() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionController.shouldBeginMultipleSelectionInteraction(
            at: indexPath,
            in: context
        ))
    }

    internal func testDidBeginMultipleSelectionInteraction() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionController.didBeginMultipleSelectionInteraction(
            at: indexPath,
            in: context
        )
    }

    internal func testContextMenuConfigurationForItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionController.contextMenuConfigurationForItem(
            at: indexPath,
            point: .zero,
            in: context
        ))
    }

    // MARK: - SectionDragDelegate

    internal func testDragItemsForBeginning() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionController.dragItems(
            forBeginning: mockSession,
            at: indexPath,
            in: context
        ).isEmpty)
    }

    internal func testDragItemsForAdding() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(sectionController.dragItems(
            forAddingTo: mockSession,
            at: indexPath,
            point: .zero,
            in: context
        ).isEmpty)
    }

    internal func testDragSessionWillBegin() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        sectionController.dragSessionWillBegin(
            mockSession,
            in: context
        )
    }

    internal func testDragSessionDidEnd() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDragSession()
        sectionController.dragSessionDidEnd(
            mockSession,
            in: context
        )
    }

    internal func testDragPreviewParametersForItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionController.dragPreviewParametersForItem(
            at: indexPath,
            in: context
        ))
    }

    // MARK: - SectionDropDelegate

    internal func testCanHandle() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        XCTAssert(sectionController.canHandle(
            drop: mockSession,
            in: context
        ))
    }

    internal func testDropSessionDidUpdate() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertEqual(
            sectionController.dropSessionDidUpdate(
                mockSession,
                at: indexPath,
                in: context
            ).operation,
            .forbidden
        )
    }

    internal func testPerformDrop() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let coordinator = MockCollectionViewDropCoordinator()
        sectionController.performDrop(
            at: indexPath,
            with: coordinator,
            in: context
        )
    }

    internal func testDropSessionDidEnter() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionController.dropSessionDidEnter(
            mockSession,
            in: context
        )
    }

    internal func testDropSessionDidExit() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionController.dropSessionDidExit(
            mockSession,
            in: context
        )
    }

    internal func testDropSessionDidEnd() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let mockSession = MockDropSession()
        sectionController.dropSessionDidEnd(
            mockSession,
            in: context
        )
    }

    internal func testDropPreviewParametersForItem() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertNil(sectionController.dropPreviewParametersForItem(
            at: indexPath,
            in: context
        ))
    }

    // MARK: - SectionFlowDelegate

    internal func testSizeForItemWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let layout = UICollectionViewFlowLayout()
        let itemSize = CGSize(width: 1, height: 2)
        layout.itemSize = itemSize
        XCTAssertEqual(
            sectionController.sizeForItem(
                at: indexPath,
                using: layout,
                in: context
            ),
            itemSize
        )
    }

    internal func testSizeForItemWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.sizeForItem(
                at: indexPath,
                using: layout,
                in: context
            ),
            CGSize(width: 50, height: 50)
        )
    }

    internal func testInsetWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewFlowLayout()
        let sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        layout.sectionInset = sectionInset
        XCTAssertEqual(
            sectionController.inset(
                using: layout,
                in: context
            ),
            sectionInset
        )
    }

    internal func testInsetWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.inset(
                using: layout,
                in: context
            ),
            .zero
        )
    }

    internal func testMinimumLineSpacingWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        XCTAssertEqual(
            sectionController.minimumLineSpacing(
                using: layout,
                in: context
            ),
            1
        )
    }

    internal func testMinimumLineSpacingWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.minimumLineSpacing(
                using: layout,
                in: context
            ),
            10
        )
    }

    internal func testMinimumInteritemSpacingWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        XCTAssertEqual(
            sectionController.minimumInteritemSpacing(
                using: layout,
                in: context
            ),
            1
        )
    }

    internal func testMinimumInteritemSpacingWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.minimumInteritemSpacing(
                using: layout,
                in: context
            ),
            10
        )
    }

    internal func testReferenceSizeForHeaderWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewFlowLayout()
        let referenceSizeForHeader = CGSize(width: 1, height: 2)
        layout.headerReferenceSize = referenceSizeForHeader
        XCTAssertEqual(
            sectionController.referenceSizeForHeader(
                using: layout,
                in: context
            ),
            referenceSizeForHeader
        )
    }

    internal func testReferenceSizeForHeaderWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.referenceSizeForHeader(
                using: layout,
                in: context
            ),
            .zero
        )
    }

    internal func testReferenceSizeForFooterWithFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewFlowLayout()
        let referenceSizeForFooter = CGSize(width: 1, height: 2)
        layout.footerReferenceSize = referenceSizeForFooter
        XCTAssertEqual(
            sectionController.referenceSizeForFooter(
                using: layout,
                in: context
            ),
            referenceSizeForFooter
        )
    }

    internal func testReferenceSizeForFooterWithoutFlowLayout() {
        let sectionController = BaseSectionController()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionController.referenceSizeForFooter(
                using: layout,
                in: context
            ),
            .zero
        )
    }
}

private final class MockSpringLoadedInteractionContext: NSObject, UISpringLoadedInteractionContext {
    var state: UISpringLoadedInteractionEffectState = .activated

    var targetView: UIView?

    var targetItem: Any?

    func location(in view: UIView?) -> CGPoint {
        .zero
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

private final class MockDragAnimating: NSObject, UIDragAnimating {
    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}

private final class MockCollectionViewDropPlaceholderContext: NSObject, UICollectionViewDropPlaceholderContext {
    var dragItem: UIDragItem = .init(itemProvider: NSItemProvider(object: "" as NSString))

    func commitInsertion(dataSourceUpdates: (IndexPath) -> Void) -> Bool { false }

    func deletePlaceholder() -> Bool { false }

    func setNeedsCellUpdate() { }

    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) { }
}
