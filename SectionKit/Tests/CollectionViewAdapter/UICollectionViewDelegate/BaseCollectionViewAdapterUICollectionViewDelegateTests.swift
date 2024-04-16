@testable import SectionKit
import UIKit
import XCTest

class BaseCollectionViewAdapterUICollectionViewDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseCollectionViewAdapterUICollectionViewDelegateTests.self else { return }
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
    ) throws -> CollectionViewAdapter & UICollectionViewDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testShouldHighlightItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldHighlightItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldHighlightItemAt: itemIndexPath.indexInCollectionView),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testShouldHighlightItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldHighlightItemAt: itemIndexPath.indexInCollectionView),
            true
        )
    }

    @MainActor
    func testDidHighlightItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didHighlightItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didHighlightItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidHighlightItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didHighlightItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testDidUnhighlightItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didUnhighlightItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didUnhighlightItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidUnhighlightItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didUnhighlightItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testShouldSelectItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldSelectItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldSelectItemAt: itemIndexPath.indexInCollectionView),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testShouldSelectItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldSelectItemAt: itemIndexPath.indexInCollectionView),
            true
        )
    }

    @MainActor
    func testShouldDeselectItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldDeselectItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldDeselectItemAt: itemIndexPath.indexInCollectionView),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testShouldDeselectItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldDeselectItemAt: itemIndexPath.indexInCollectionView),
            true
        )
    }

    @MainActor
    func testDidSelectItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didSelectItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didSelectItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidSelectItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didSelectItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testDidDeselectItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didDeselectItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didDeselectItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidDeselectItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didDeselectItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testWillDisplayCell() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemCell = MockCollectionViewCell()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._willDisplayCell = { cell, indexPath, _ in
                            XCTAssert(cell === itemCell)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, willDisplay: itemCell, forItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testWillDisplayCellWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemCell = MockCollectionViewCell()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, willDisplay: itemCell, forItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testWillDisplayHeaderView() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemHeaderView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._willDisplayHeaderView = { headerView, indexPath, _ in
                            XCTAssert(headerView === itemHeaderView)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            willDisplaySupplementaryView: itemHeaderView,
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testWillDisplayFooterView() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemFooterView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._willDisplayFooterView = { headerView, indexPath, _ in
                            XCTAssert(headerView === itemFooterView)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            willDisplaySupplementaryView: itemFooterView,
            forElementKind: UICollectionView.elementKindSectionFooter,
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testWillDisplaySupplementaryViewWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemHeaderView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            willDisplaySupplementaryView: itemHeaderView,
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: itemIndexPath.indexInCollectionView
        )
    }

    @MainActor
    func testWillDisplaySupplementaryViewWithInvalidElementKind() throws {
        let delegateExpectation = expectation(description: "Should not invoke delegate")
        delegateExpectation.fulfill()
        let errorExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemFooterView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._willDisplayHeaderView = { headerView, indexPath, _ in
                            delegateExpectation.fulfill()
                        }
                        delegate._willDisplayFooterView = { headerView, indexPath, _ in
                            delegateExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .unsupportedSupplementaryViewKind(elementKind) = error, elementKind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
                XCTAssertEqual(severity, .informational)
                errorExpectation.fulfill()
            }
        )
        adapter.collectionView?(
            collectionView,
            willDisplaySupplementaryView: itemFooterView,
            forElementKind: "test",
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidEndDisplayingCell() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemCell = MockCollectionViewCell()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didEndDisplayingCell = { cell, indexPath, _ in
                            XCTAssert(cell === itemCell)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didEndDisplaying: itemCell, forItemAt: itemIndexPath.indexInCollectionView)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidEndDisplayingCellWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemCell = MockCollectionViewCell()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(collectionView, didEndDisplaying: itemCell, forItemAt: itemIndexPath.indexInCollectionView)
    }

    @MainActor
    func testDidEndDisplayingHeaderView() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemHeaderView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didEndDisplayingHeaderView = { headerView, indexPath, _ in
                            XCTAssert(headerView === itemHeaderView)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            didEndDisplayingSupplementaryView: itemHeaderView,
            forElementOfKind: UICollectionView.elementKindSectionHeader,
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidEndDisplayingFooterView() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemFooterView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didEndDisplayingFooterView = { headerView, indexPath, _ in
                            XCTAssert(headerView === itemFooterView)
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            didEndDisplayingSupplementaryView: itemFooterView,
            forElementOfKind: UICollectionView.elementKindSectionFooter,
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testDidEndDisplayingSupplementaryViewWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemHeaderView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            didEndDisplayingSupplementaryView: itemHeaderView,
            forElementOfKind: UICollectionView.elementKindSectionHeader,
            at: itemIndexPath.indexInCollectionView
        )
    }

    @MainActor
    func testDidEndDisplayingSupplementaryWithInvalidElementKind() throws {
        let delegateExpectation = expectation(description: "Should not invoke delegate")
        delegateExpectation.fulfill()
        let errorExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemFooterView = MockCollectionReusableView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didEndDisplayingHeaderView = { headerView, indexPath, _ in
                            delegateExpectation.fulfill()
                        }
                        delegate._didEndDisplayingFooterView = { headerView, indexPath, _ in
                            delegateExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .unsupportedSupplementaryViewKind(elementKind) = error, elementKind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
                XCTAssertEqual(severity, .informational)
                errorExpectation.fulfill()
            }
        )
        adapter.collectionView?(
            collectionView,
            didEndDisplayingSupplementaryView: itemFooterView,
            forElementOfKind: "test",
            at: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testShouldShowMenuForItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldShowMenuForItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldShowMenuForItemAt: itemIndexPath.indexInCollectionView),
            true
        )
        waitForExpectations(timeout: 1)
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testShouldShowMenuForItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, shouldShowMenuForItemAt: itemIndexPath.indexInCollectionView),
            false
        )
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
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._canPerform = { action, indexPath, sender, _ in
                            XCTAssertEqual(action, #selector(Mock.perform))
                            XCTAssertEqual(indexPath, itemIndexPath)
                            XCTAssert((sender as? Mock) === mockSender)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                canPerformAction: #selector(Mock.perform),
                forItemAt: itemIndexPath.indexInCollectionView,
                withSender: mockSender
            ),
            true
        )
        waitForExpectations(timeout: 1)
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testCanPerformWithoutDelegate() throws {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                canPerformAction: #selector(Mock.perform),
                forItemAt: itemIndexPath.indexInCollectionView,
                withSender: mockSender
            ),
            false
        )
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
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._perform = { action, indexPath, sender, _ in
                            XCTAssertEqual(action, #selector(Mock.perform))
                            XCTAssertEqual(indexPath, itemIndexPath)
                            XCTAssert((sender as? Mock) === mockSender)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            performAction: #selector(Mock.perform),
            forItemAt: itemIndexPath.indexInCollectionView,
            withSender: mockSender
        )
        waitForExpectations(timeout: 1)
    }

    // availability attribute is needed because of deprecation warning
    @MainActor
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func testPerformWithoutDelegate() throws {
        class Mock {
            @objc
            func perform() { }
        }
        let mockSender = Mock()
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            performAction: #selector(Mock.perform),
            forItemAt: itemIndexPath.indexInCollectionView,
            withSender: mockSender
        )
    }

    @MainActor
    func testTransitionLayoutForOldLayout() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        let fromLayout = UICollectionViewFlowLayout()
        let toLayout = UICollectionViewFlowLayout()
        let transitionLayout = try XCTUnwrap(
            adapter.collectionView?(
                collectionView,
                transitionLayoutForOldLayout: fromLayout,
                newLayout: toLayout
            )
        )
        XCTAssert(transitionLayout.currentLayout === fromLayout)
        XCTAssert(transitionLayout.nextLayout === toLayout)
    }

    @MainActor
    func testCanFocusItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._canFocusItem = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, canFocusItemAt: itemIndexPath.indexInCollectionView),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCanFocusItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, canFocusItemAt: itemIndexPath.indexInCollectionView),
            true
        )
    }

    // Not possible to instantiate `UICollectionViewFocusUpdateContext`
//    func testShouldUpdateFocus() throws {
//        let collectionView = createCollectionView()
//        let adapter = try createCollectionViewAdapter(
//            collectionView: collectionView,
//            sections: [
//                Section(id: "", model: "", controller: MockSectionController())
//            ]
//        )
//        XCTAssertEqual(
//            adapter.collectionView?(collectionView, shouldUpdateFocusIn: UICollectionViewFocusUpdateContext()),
//            true
//        )
//    }

    // Not possible to instantiate `UICollectionViewFocusUpdateContext`
//    func testDidUpdateFocus() throws {
//        let collectionView = createCollectionView()
//        let adapter = try createCollectionViewAdapter(
//            collectionView: collectionView,
//            sections: [
//                Section(id: "", model: "", controller: MockSectionController())
//            ]
//        )
//        adapter.collectionView?(
//            collectionView,
//            didUpdateFocusIn: UICollectionViewFocusUpdateContext(),
//            with: UIFocusAnimationCoordinator()
//        )
//    }

    @MainActor
    func testIndexPathForPreferredFocusedView() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertNil(adapter.indexPathForPreferredFocusedView?(in: collectionView))
    }

    @MainActor
    func testTargetIndexPathForMoveFromItem() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        let fromIndexPath = IndexPath(item: 1, section: 2)
        let toIndexPath = IndexPath(item: 4, section: 8)
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                targetIndexPathForMoveFromItemAt: fromIndexPath,
                toProposedIndexPath: toIndexPath
            ),
            toIndexPath
        )
    }

    @MainActor
    func testTargetContentOffsetForProposedContentOffset() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        let offset = CGPoint(x: 1, y: 2)
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                targetContentOffsetForProposedContentOffset: offset
            ),
            offset
        )
    }

    @MainActor
    @available(iOS 11.0, *)
    func testShouldSpringLoadItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let mockContext = MockSpringLoadedInteractionContext()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldSpringLoadItem = { indexPath, context, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            XCTAssert(context === mockContext)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                shouldSpringLoadItemAt: itemIndexPath.indexInCollectionView,
                with: mockContext
            ),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testShouldSpringLoadItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let mockContext = MockSpringLoadedInteractionContext()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                shouldSpringLoadItemAt: itemIndexPath.indexInCollectionView,
                with: mockContext
            ),
            true
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testShouldBeginMultipleSelectionInteraction() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._shouldBeginMultipleSelectionInteraction = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                            return true
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                shouldBeginMultipleSelectionInteractionAt: itemIndexPath.indexInCollectionView
            ),
            true
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    @available(iOS 13.0, *)
    func testShouldBeginMultipleSelectionInteractionWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(
                collectionView,
                shouldBeginMultipleSelectionInteractionAt: itemIndexPath.indexInCollectionView
            ),
            false
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testDidBeginMultipleSelectionInteraction() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._didBeginMultipleSelectionInteraction = { indexPath, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            testExpectation.fulfill()
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            didBeginMultipleSelectionInteractionAt: itemIndexPath.indexInCollectionView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    @available(iOS 13.0, *)
    func testDidBeginMultipleSelectionInteractionWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            didBeginMultipleSelectionInteractionAt: itemIndexPath.indexInCollectionView
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testDidEndMultipleSelectionInteraction() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        adapter.collectionViewDidEndMultipleSelectionInteraction?(collectionView)
    }

    @MainActor
    @available(iOS 13.0, *)
    func testContextMenuConfigurationForItem() throws {
        let testExpectation = expectation(description: "Should invoke delegate")
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemPoint = CGPoint(x: 1, y: 2)
        let itemConfiguration = UIContextMenuConfiguration()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = {
                        let delegate = MockSectionDelegate()
                        delegate._contextMenuConfigurationForItem = { indexPath, point, _ in
                            XCTAssertEqual(indexPath, itemIndexPath)
                            XCTAssertEqual(point, itemPoint)
                            testExpectation.fulfill()
                            return itemConfiguration
                        }
                        return delegate
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssert(
            adapter.collectionView?(
                collectionView,
                contextMenuConfigurationForItemAt: itemIndexPath.indexInCollectionView,
                point: itemPoint
            ) === itemConfiguration
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    @available(iOS 13.0, *)
    func testContextMenuConfigurationForItemWithoutDelegate() throws {
        let collectionView = createCollectionView()
        let itemIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let itemPoint = CGPoint(x: 1, y: 2)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.delegate = nil
                    return sectionController
                })
            ]
        )
        XCTAssertNil(
            adapter.collectionView?(
                collectionView,
                contextMenuConfigurationForItemAt: itemIndexPath.indexInCollectionView,
                point: itemPoint
            )
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testPreviewForHighlightingContextMenuWithConfiguration() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertNil(
            adapter.collectionView?(
                collectionView,
                previewForHighlightingContextMenuWithConfiguration: UIContextMenuConfiguration()
            )
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testPreviewForDismissingContextMenuWithConfiguration() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertNil(
            adapter.collectionView?(
                collectionView,
                previewForDismissingContextMenuWithConfiguration: UIContextMenuConfiguration()
            )
        )
    }

    @MainActor
    @available(iOS 13.0, *)
    func testWillPerformPreviewActionForMenu() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        adapter.collectionView?(
            collectionView,
            willPerformPreviewActionForMenuWith: UIContextMenuConfiguration(),
            animator: MockContextMenuInteractionCommitAnimating()
        )
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

@available(iOS 13.0, *)
private class MockContextMenuInteractionCommitAnimating: NSObject, UIContextMenuInteractionCommitAnimating {
    var preferredCommitStyle: UIContextMenuInteractionCommitStyle = .dismiss

    var previewViewController: UIViewController?

    func addAnimations(_ animations: @escaping () -> Void) { }

    func addCompletion(_ completion: @escaping () -> Void) { }
}
