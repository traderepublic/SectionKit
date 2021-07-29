@testable import SectionKit
import XCTest

internal final class ListSectionControllerTests: XCTestCase {
    internal func testDidUpdateModelWithValidTypeSetsModel() {
        let sectionController = ListSectionController<String, String>(model: "1")
        sectionController.didUpdate(model: "2")
        XCTAssertEqual(sectionController.model, "2")
    }

    internal func testDidUpdateModelWithInvalidType() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = ListSectionController<String, String>(model: "1")
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error in
                guard case let .sectionControllerModelTypeMismatch(expected, actual) = error else {
                    XCTFail("The error should be sectionControllerModelTypeMismatch")
                    return
                }
                XCTAssert(expected == String.self)
                XCTAssert(actual == Int.self)
                errorExpectation.fulfill()
            }
        )
        sectionController.context = context
        sectionController.didUpdate(model: 2)
        XCTAssertEqual(sectionController.model, "1")
        waitForExpectations(timeout: 1)
    }

    internal func testInitDoesNotUpdateItemsIfShouldNotUpdateItems() {
        class TestSectionController: ListSectionController<String, String> {
            var itemsForModelExpectation: XCTestExpectation?

            init(model: String, itemsForModelExpectation: XCTestExpectation?) {
                self.itemsForModelExpectation = itemsForModelExpectation
                super.init(model: model)
            }

            override func shouldUpdateItems(afterModelChangedTo model: String) -> Bool {
                false
            }

            override func items(for model: String) -> [String] {
                itemsForModelExpectation?.fulfill()
                return []
            }
        }
        let itemsForModelExpectation = expectation(description: "Should not invoke items(for:)")
        itemsForModelExpectation.fulfill()
        let _ = TestSectionController(model: "1", itemsForModelExpectation: itemsForModelExpectation)
        waitForExpectations(timeout: 1)
    }

    internal func testSettingModelDoesNotUpdateItemsIfShouldNotUpdateItems() {
        class TestSectionController: ListSectionController<String, String> {
            var itemsForModelExpectation: XCTestExpectation?

            init(model: String, itemsForModelExpectation: XCTestExpectation?) {
                self.itemsForModelExpectation = itemsForModelExpectation
                super.init(model: model)
            }

            override func shouldUpdateItems(afterModelChangedTo model: String) -> Bool {
                false
            }

            override func items(for model: String) -> [String] {
                itemsForModelExpectation?.fulfill()
                return []
            }
        }
        let itemsForModelExpectation = expectation(description: "Should not invoke items(for:)")
        itemsForModelExpectation.fulfill()
        let sectionController = TestSectionController(model: "1", itemsForModelExpectation: nil)
        // set expectation after init so a possible bug in the init is not caught by this test
        sectionController.itemsForModelExpectation = itemsForModelExpectation
        sectionController.model = "2"
        waitForExpectations(timeout: 1)
    }

    internal func testShouldUpdateItemsDefaultsToTrue() {
        let sectionController = ListSectionController<String, String>(model: "1")
        XCTAssert(sectionController.shouldUpdateItems(afterModelChangedTo: "2"))
    }

    internal func testItemsForModelInvokesNotImplementedError() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = ListSectionController<String, String>(model: "1")
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
        sectionController.context = context
        XCTAssertEqual(sectionController.items(for: "2"), [])
        waitForExpectations(timeout: 1)
    }

    internal func testNumberOfItems() {
        let sectionController = ListSectionController<String, String>(model: "1")
        sectionController.items = ["1", "2"]
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { _ in }
        )
        XCTAssertEqual(sectionController.numberOfItems(in: context), 2)
    }
}
