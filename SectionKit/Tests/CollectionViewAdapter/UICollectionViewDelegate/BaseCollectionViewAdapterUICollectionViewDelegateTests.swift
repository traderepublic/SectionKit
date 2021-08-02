@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUICollectionViewDelegateTests: XCTestCase {
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
    ) throws -> CollectionViewAdapter & UICollectionViewDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func testShouldHighlightItem() throws {
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

    internal func testShouldHighlightItemWithoutDelegate() throws {
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

    internal func testDidHighlightItem() throws {
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

    internal func testDidHighlightItemWithoutDelegate() throws {
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

    internal func testDidUnhighlightItem() throws {
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

    internal func testDidUnhighlightItemWithoutDelegate() throws {
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

    internal func testShouldSelectItem() throws {
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

    internal func testShouldSelectItemWithoutDelegate() throws {
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

    internal func testShouldDeselectItem() throws {
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

    internal func testShouldDeselectItemWithoutDelegate() throws {
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

    internal func testDidSelectItem() throws {
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

    internal func testDidSelectItemWithoutDelegate() throws {
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

    internal func testDidDeselectItem() throws {
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

    internal func testDidDeselectItemWithoutDelegate() throws {
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

    internal func testWillDisplayCell() throws {
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

    internal func testWillDisplayCellWithoutDelegate() throws {
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

    internal func testWillDisplayHeaderView() throws {
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

    internal func testWillDisplayFooterView() throws {
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

    internal func testWillDisplaySupplementaryViewWithoutDelegate() throws {
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

    internal func testWillDisplaySupplementaryViewWithInvalidElementKind() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .unsupportedSupplementaryViewKind(elementKind) = error, elementKind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
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

    internal func testDidEndDisplayingCell() throws {
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

    internal func testDidEndDisplayingCellWithoutDelegate() throws {
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

    internal func testDidEndDisplayingHeaderView() throws {
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

    internal func testDidEndDisplayingFooterView() throws {
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

    internal func testDidEndDisplayingSupplementaryViewWithoutDelegate() throws {
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

    internal func testDidEndDisplayingSupplementaryWithInvalidElementKind() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .unsupportedSupplementaryViewKind(elementKind) = error, elementKind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testShouldShowMenuForItem() throws {
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testShouldShowMenuForItemWithoutDelegate() throws {
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testCanPerform() throws {
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testCanPerformWithoutDelegate() throws {
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testPerform() throws {
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
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    internal func testPerformWithoutDelegate() throws {
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

    internal func testTransitionLayoutForOldLayout() throws {
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

    internal func testCanFocusItem() throws {
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

    internal func testCanFocusItemWithoutDelegate() throws {
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
//    internal func testShouldUpdateFocus() throws {
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
//    internal func testDidUpdateFocus() throws {
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

    internal func testIndexPathForPreferredFocusedView() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertNil(adapter.indexPathForPreferredFocusedView?(in: collectionView))
    }

    internal func testTargetIndexPathForMoveFromItem() throws {
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

    internal func testTargetContentOffsetForProposedContentOffset() throws {
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

    @available(iOS 11.0, *)
    internal func testShouldSpringLoadItem() throws {
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

    @available(iOS 11.0, *)
    internal func testShouldSpringLoadItemWithoutDelegate() throws {
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

    @available(iOS 13.0, *)
    internal func testShouldBeginMultipleSelectionInteraction() throws {
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

    @available(iOS 13.0, *)
    internal func testShouldBeginMultipleSelectionInteractionWithoutDelegate() throws {
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

    @available(iOS 13.0, *)
    internal func testDidBeginMultipleSelectionInteraction() throws {
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

    @available(iOS 13.0, *)
    internal func testDidBeginMultipleSelectionInteractionWithoutDelegate() throws {
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

    @available(iOS 13.0, *)
    internal func testDidEndMultipleSelectionInteraction() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        adapter.collectionViewDidEndMultipleSelectionInteraction?(collectionView)
    }

    @available(iOS 13.0, *)
    internal func testContextMenuConfigurationForItem() throws {
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

    @available(iOS 13.0, *)
    internal func testContextMenuConfigurationForItemWithoutDelegate() throws {
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

    @available(iOS 13.0, *)
    internal func testPreviewForHighlightingContextMenuWithConfiguration() throws {
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

    @available(iOS 13.0, *)
    internal func testPreviewForDismissingContextMenuWithConfiguration() throws {
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

    @available(iOS 13.0, *)
    internal func testWillPerformPreviewActionForMenu() throws {
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
