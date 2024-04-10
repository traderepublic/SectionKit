@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUICollectionViewDelegateFlowLayoutTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    internal func skipIfNeeded() throws {
        guard Self.self === BaseCollectionViewAdapterUICollectionViewDelegateFlowLayoutTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func createCollectionView(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout? = nil
    ) -> UICollectionView {
        UICollectionView(frame: frame, collectionViewLayout: layout ?? UICollectionViewFlowLayout())
    }

    @MainActor
    internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDelegateFlowLayout {
        throw XCTSkip("Tests from base class are skipped")
    }

    // MARK: - sizeForItem
    @MainActor
    internal func testSizeForItemWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let itemSize = CGSize(width: 1, height: 2)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._sizeForItem = { indexPath, layout, _ in
                            XCTAssertEqual(indexPath.indexInCollectionView, itemIndexPath)
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return itemSize
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, sizeForItemAt: itemIndexPath),
            itemSize
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testSizeForItemWithoutDelegateButWithFlowLayout() throws {
        let itemSize = CGSize(width: 1, height: 2)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = itemSize
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, sizeForItemAt: itemIndexPath),
            itemSize
        )
    }

    @MainActor
    internal func testSizeForItemWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let itemIndexPath = IndexPath(item: 0, section: 0)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, sizeForItemAt: itemIndexPath),
            CGSize(width: 50, height: 50)
        )
    }

    // MARK: - inset

    @MainActor
    internal func testInsetWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._inset = { layout, _ in
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return sectionInset
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, insetForSectionAt: 0),
            sectionInset
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testInsetWithoutDelegateButWithFlowLayout() throws {
        let sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = sectionInset
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, insetForSectionAt: 0),
            sectionInset
        )
    }

    @MainActor
    internal func testInsetWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, insetForSectionAt: 0),
            .zero
        )
    }

    // MARK: - minimumLineSpacing

    @MainActor
    internal func testMinimumLineSpacingWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let lineSpacing: CGFloat = 1
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._minimumLineSpacing = { layout, _ in
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return lineSpacing
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, minimumLineSpacingForSectionAt: 0),
            lineSpacing
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testMinimumLineSpacingWithoutDelegateButWithFlowLayout() throws {
        let lineSpacing: CGFloat = 1
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = lineSpacing
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, minimumLineSpacingForSectionAt: 0),
            lineSpacing
        )
    }

    @MainActor
    internal func testMinimumLineSpacingWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, minimumLineSpacingForSectionAt: 0),
            10
        )
    }

    // MARK: - minimumInteritemSpacing

    @MainActor
    internal func testMinimumInteritemSpacingWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let interitemSpacing: CGFloat = 1
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._minimumInteritemSpacing = { layout, _ in
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return interitemSpacing
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, minimumInteritemSpacingForSectionAt: 0),
            interitemSpacing
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testMinimumInteritemSpacingWithoutDelegateButWithFlowLayout() throws {
        let interitemSpacing: CGFloat = 1
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = interitemSpacing
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, minimumInteritemSpacingForSectionAt: 0),
            interitemSpacing
        )
    }

    @MainActor
    internal func testMinimumInteritemSpacingWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, minimumInteritemSpacingForSectionAt: 0),
            10
        )
    }

    // MARK: - referenceSizeForHeader

    @MainActor
    internal func testReferenceSizeForHeaderWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let headerSize = CGSize(width: 1, height: 2)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._referenceSizeForHeader = { layout, _ in
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return headerSize
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, referenceSizeForHeaderInSection: 0),
            headerSize
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testReferenceSizeForHeaderWithoutDelegateButWithFlowLayout() throws {
        let headerSize = CGSize(width: 1, height: 2)
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = headerSize
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, referenceSizeForHeaderInSection: 0),
            headerSize
        )
    }

    @MainActor
    internal func testReferenceSizeForHeaderWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, referenceSizeForHeaderInSection: 0),
            .zero
        )
    }

    // MARK: - referenceSizeForFooter

    @MainActor
    internal func testReferenceSizeForFooterWithDelegate() throws {
        let testExpectation = expectation(description: "Should invoke flow layout delegate")
        let mockLayout = UICollectionViewFlowLayout()
        let collectionView = createCollectionView(collectionViewLayout: mockLayout)
        let footerSize = CGSize(width: 1, height: 2)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = {
                        let flowDelegate = MockSectionFlowDelegate()
                        flowDelegate._referenceSizeForFooter = { layout, _ in
                            XCTAssert(layout === mockLayout)
                            testExpectation.fulfill()
                            return footerSize
                        }
                        return .flowLayout(flowDelegate)
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: mockLayout, referenceSizeForFooterInSection: 0),
            footerSize
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    internal func testReferenceSizeForFooterWithoutDelegateButWithFlowLayout() throws {
        let footerSize = CGSize(width: 1, height: 2)
        let layout = UICollectionViewFlowLayout()
        layout.footerReferenceSize = footerSize
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, referenceSizeForFooterInSection: 0),
            footerSize
        )
    }

    @MainActor
    internal func testReferenceSizeForFooterWithoutDelegateAndFlowLayout() throws {
        let layout = UICollectionViewLayout()
        let collectionView = createCollectionView(collectionViewLayout: layout)
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.layoutProvider = nil
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, layout: layout, referenceSizeForFooterInSection: 0),
            .zero
        )
    }
}
