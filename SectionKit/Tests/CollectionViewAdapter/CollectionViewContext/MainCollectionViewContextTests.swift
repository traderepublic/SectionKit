@testable import SectionKit
import XCTest

internal final class MainCollectionViewContextTests: XCTestCase {
    internal func testSectionAdapterIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        var adapter: CollectionViewAdapter? = ListCollectionViewAdapter(collectionView: collectionView)
        context.sectionAdapter = adapter
        adapter = nil
        XCTAssertNil(context.sectionAdapter)
    }

    internal func testViewControllerIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: UIViewController(),
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        XCTAssertNil(context.viewController)
    }

    internal func testApplySectionUpdate() {
        let collectionViewExpectation = expectation(description: "reloadData should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = collectionViewExpectation.fulfill
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        let sectionController = MockSectionController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: sectionController)
            ]
        )
        context.sectionAdapter = adapter
        let update = CollectionViewSectionUpdate(
            controller: sectionController,
            data: "",
            setData: { _ in }
        )
        context.apply(update: update)
        waitForExpectations(timeout: 1)
    }

    internal func testApplySectionUpdateWhenSectionAdapterIsNotSetThenReloadDataIsCalled() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let collectionViewExpectation = expectation(description: "reloadData should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = collectionViewExpectation.fulfill
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case .sectionAdapterIsNotSet = error else {
                    XCTFail("The error should be sectionAdapterIsNotSet")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        let update = CollectionViewSectionUpdate(
            controller: MockSectionController(),
            data: "",
            setData: { _ in }
        )
        context.apply(update: update)
        waitForExpectations(timeout: 1)
    }

    internal func testApplySectionUpdateWhenSectionControllerIsNotPartOfTheAdapterThenReloadDataIsCalled() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let collectionViewExpectation = expectation(description: "reloadData should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = collectionViewExpectation.fulfill
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case .sectionControllerNotPartOfAdapter = error else {
                    XCTFail("The error should be sectionControllerNotPartOfAdapter")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        context.sectionAdapter = adapter
        let update = CollectionViewSectionUpdate(
            controller: MockSectionController(),
            data: "",
            setData: { _ in }
        )
        context.apply(update: update)
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableCellWhenCellIsNotRegisteredYet() {
        let registerExpectation = expectation(description: "The cell should be registered")
        let dequeueExpectation = expectation(description: "The cell should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockCell = MockCollectionViewCell()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerCell = { cellType, identifier in
            XCTAssert(cellType === MockCollectionViewCell.self)
            XCTAssertEqual(identifier, String(describing: MockCollectionViewCell.self))
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableCell = { identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionViewCell.self))
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockCell
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        XCTAssert(
            context.dequeueReusableCell(
                MockCollectionViewCell.self,
                for: mockIndexPath
            ) === mockCell
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableCellWhenCellIsAlreadyRegistered() {
        let registerExpectation = expectation(description: "The cell should not be registered")
        registerExpectation.fulfill()
        let dequeueExpectation = expectation(description: "The cell should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockCell = MockCollectionViewCell()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerCell = { _, _ in
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableCell = { identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionViewCell.self))
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockCell
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        context.registeredCellTypes.insert(String(describing: MockCollectionViewCell.self))
        XCTAssert(
            context.dequeueReusableCell(
                MockCollectionViewCell.self,
                for: mockIndexPath
            ) === mockCell
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableCellWhenInvalidCellIsRegistered() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let dequeueExpectation = expectation(description: "The cell should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        class CustomCollectionViewCell: UICollectionViewCell { }
        let wrongCell = CustomCollectionViewCell()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._dequeueReusableCell = { identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionViewCell.self))
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return wrongCell
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case let .dequeuedViewIsNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewIsNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionViewCell.self)
                XCTAssert(actual === CustomCollectionViewCell.self)
                errorExpectation.fulfill()
            }
        )
        let _ = context.dequeueReusableCell(
            MockCollectionViewCell.self,
            for: mockIndexPath
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableHeaderViewWhenHeaderViewIsNotRegisteredYet() {
        let registerExpectation = expectation(description: "The header view should be registered")
        let dequeueExpectation = expectation(description: "The header view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockView = MockCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerSupplementaryView = { viewType, elementKind, identifier in
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionHeader)
            XCTAssert(viewType === MockCollectionReusableView.self)
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionHeader)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        XCTAssert(
            context.dequeueReusableHeaderView(
                MockCollectionReusableView.self,
                for: mockIndexPath
            ) === mockView
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableHeaderViewWhenHeaderViewIsAlreadyRegistered() {
        let registerExpectation = expectation(description: "The header view should not be registered")
        registerExpectation.fulfill()
        let dequeueExpectation = expectation(description: "The header view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockView = MockCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerSupplementaryView = { _, _, _ in
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionHeader)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        context.registeredHeaderViewTypes.insert(String(describing: MockCollectionReusableView.self))
        XCTAssert(
            context.dequeueReusableHeaderView(
                MockCollectionReusableView.self,
                for: mockIndexPath
            ) === mockView
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableHeaderViewWhenInvalidHeaderViewIsRegistered() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let dequeueExpectation = expectation(description: "The header view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        class CustomCollectionReusableView: UICollectionReusableView { }
        let wrongView = CustomCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionHeader)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return wrongView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case let .dequeuedViewIsNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewIsNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionReusableView.self)
                XCTAssert(actual === CustomCollectionReusableView.self)
                errorExpectation.fulfill()
            }
        )
        let _ = context.dequeueReusableHeaderView(
            MockCollectionReusableView.self,
            for: mockIndexPath
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableFooterViewWhenFooterViewIsNotRegisteredYet() {
        let registerExpectation = expectation(description: "The footer view should be registered")
        let dequeueExpectation = expectation(description: "The footer view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockView = MockCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerSupplementaryView = { viewType, elementKind, identifier in
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionFooter)
            XCTAssert(viewType === MockCollectionReusableView.self)
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionFooter)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        XCTAssert(
            context.dequeueReusableFooterView(
                MockCollectionReusableView.self,
                for: mockIndexPath
            ) === mockView
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableFooterViewWhenFooterViewIsAlreadyRegistered() {
        let registerExpectation = expectation(description: "The footer view should not be registered")
        registerExpectation.fulfill()
        let dequeueExpectation = expectation(description: "The footer view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        let mockView = MockCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._registerSupplementaryView = { _, _, _ in
            registerExpectation.fulfill()
        }
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionFooter)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return mockView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        context.registeredFooterViewTypes.insert(String(describing: MockCollectionReusableView.self))
        XCTAssert(
            context.dequeueReusableFooterView(
                MockCollectionReusableView.self,
                for: mockIndexPath
            ) === mockView
        )
        waitForExpectations(timeout: 1)
    }

    internal func testDequeueReusableFooterViewWhenInvalidFooterViewIsRegistered() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let dequeueExpectation = expectation(description: "The footer view should be dequeued")
        let mockIndexPath = IndexPath(item: 1, section: 2)
        class CustomCollectionReusableView: UICollectionReusableView { }
        let wrongView = CustomCollectionReusableView()
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._dequeueReusableSupplementaryView = { elementKind, identifier, indexPath in
            XCTAssertEqual(identifier, String(describing: MockCollectionReusableView.self))
            XCTAssertEqual(elementKind, UICollectionView.elementKindSectionFooter)
            XCTAssertEqual(indexPath, mockIndexPath)
            dequeueExpectation.fulfill()
            return wrongView
        }
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case let .dequeuedViewIsNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewIsNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionReusableView.self)
                XCTAssert(actual === CustomCollectionReusableView.self)
                errorExpectation.fulfill()
            }
        )
        let _ = context.dequeueReusableFooterView(
            MockCollectionReusableView.self,
            for: mockIndexPath
        )
        waitForExpectations(timeout: 1)
    }

    internal func testSectionControllerWithAdjustedIndexPath() {
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        let sectionController = MockSectionController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: sectionController)
            ]
        )
        context.sectionAdapter = adapter
        let indexPath = IndexPath(item: 0, section: 0)
        let actual = context.sectionControllerWithAdjustedIndexPath(for: indexPath)
        XCTAssert(actual?.0 === sectionController)
        XCTAssertEqual(actual?.1.indexInCollectionView, indexPath)
    }

    internal func testSectionControllerWithAdjustedIndexPathWhenSectionDoesNotExist() {
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { _ in }
        )
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        context.sectionAdapter = adapter
        XCTAssertNil(context.sectionControllerWithAdjustedIndexPath(for: IndexPath(item: 0, section: 0)))
    }

    internal func testSectionControllerWithAdjustedIndexPathWhenSectionAdapterIsNotSet() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case .sectionAdapterIsNotSet = error else {
                    XCTFail("The error should be sectionAdapterIsNotSet")
                    return
                }
                errorExpectation.fulfill()
            }
        )
        XCTAssertNil(context.sectionControllerWithAdjustedIndexPath(for: IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }
}

private class MockCollectionView: UICollectionView {
    // MARK: - reloadData

    typealias ReloadDataBlock = () -> Void

    lazy var _reloadData: ReloadDataBlock = { }

    override func reloadData() {
        _reloadData()
    }

    // MARK: - registerCell

    typealias RegisterCellBlock = (AnyClass?, String) -> Void

    lazy var _registerCell: RegisterCellBlock = { _, _ in }

    override func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        _registerCell(cellClass, identifier)
    }

    // MARK: - dequeueReusableCell

    typealias DequeueReusableCellBlock = (String, IndexPath) -> UICollectionViewCell

    lazy var _dequeueReusableCell: DequeueReusableCellBlock = { _, _ in UICollectionViewCell() }

    override func dequeueReusableCell(
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {
        _dequeueReusableCell(identifier, indexPath)
    }

    // MARK: - registerSupplementaryView

    typealias RegisterSupplementaryViewBlock = (AnyClass?, String, String) -> Void

    lazy var _registerSupplementaryView: RegisterSupplementaryViewBlock = { _, _, _ in }

    override func register(
        _ viewClass: AnyClass?,
        forSupplementaryViewOfKind elementKind: String,
        withReuseIdentifier identifier: String
    ) {
        _registerSupplementaryView(viewClass, elementKind, identifier)
    }

    // MARK: - dequeueReusableSupplementaryView

    typealias DequeueReusableSupplementaryViewBlock = (String, String, IndexPath) -> UICollectionReusableView

    lazy var _dequeueReusableSupplementaryView: DequeueReusableSupplementaryViewBlock = { _, _, _ in UICollectionReusableView() }

    override func dequeueReusableSupplementaryView(
        ofKind elementKind: String,
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UICollectionReusableView {
        _dequeueReusableSupplementaryView(elementKind, identifier, indexPath)
    }
}
