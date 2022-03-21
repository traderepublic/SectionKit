@testable import SectionKit
import XCTest

internal final class MainCollectionViewContextTests: XCTestCase {
    internal func testAdapterIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
        )
        var adapter: CollectionViewAdapter? = ListCollectionViewAdapter(collectionView: collectionView)
        context.adapter = adapter
        adapter = nil
        XCTAssertNil(context.adapter)
    }

    internal func testViewControllerIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: UIViewController(),
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler()
        )
        let sectionController = MockSectionController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: sectionController)
            ]
        )
        context.adapter = adapter
        let update = CollectionViewSectionUpdate(
            controller: sectionController,
            data: "",
            setData: { _ in }
        )
        context.apply(update: update)
        waitForExpectations(timeout: 1)
    }

    internal func testApplySectionUpdateWhenAdapterIsNotSetThenReloadDataIsCalled() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let collectionViewExpectation = expectation(description: "reloadData should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = collectionViewExpectation.fulfill
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error, severity in
                guard case .adapterIsNotSetOnContext = error else {
                    XCTFail("The error should be adapterIsNotSetOnContext")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
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
            errorHandler: MockErrorHandler { error, severity in
                guard case .adapterDoesNotContainSectionController = error else {
                    XCTFail("The error should be adapterDoesNotContainSectionController")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        context.adapter = adapter
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler { error, severity in
                guard case let .dequeuedViewHasNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewHasNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionViewCell.self)
                XCTAssert(actual === CustomCollectionViewCell.self)
                XCTAssertEqual(severity, .nonCritical)
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler { error, severity in
                guard case let .dequeuedViewHasNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewHasNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionReusableView.self)
                XCTAssert(actual === CustomCollectionReusableView.self)
                XCTAssertEqual(severity, .nonCritical)
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler()
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
            errorHandler: MockErrorHandler { error, severity in
                guard case let .dequeuedViewHasNotTheCorrectType(expected: expected, actual: actual) = error else {
                    XCTFail("The error should be dequeuedViewHasNotTheCorrectType")
                    return
                }
                XCTAssert(expected === MockCollectionReusableView.self)
                XCTAssert(actual === CustomCollectionReusableView.self)
                XCTAssertEqual(severity, .nonCritical)
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
            errorHandler: MockErrorHandler()
        )
        let sectionController = MockSectionController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: sectionController)
            ]
        )
        context.adapter = adapter
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
            errorHandler: MockErrorHandler()
        )
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        context.adapter = adapter
        XCTAssertNil(context.sectionControllerWithAdjustedIndexPath(for: IndexPath(item: 0, section: 0)))
    }

    internal func testSectionControllerWithAdjustedIndexPathWhenAdapterIsNotSet() {
        let errorExpectation = expectation(description: "The errorHandler should be invoked")
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error, severity in
                guard case .adapterIsNotSetOnContext = error else {
                    XCTFail("The error should be adapterIsNotSetOnContext")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        XCTAssertNil(context.sectionControllerWithAdjustedIndexPath(for: IndexPath(item: 0, section: 0)))
        waitForExpectations(timeout: 1)
    }
}
