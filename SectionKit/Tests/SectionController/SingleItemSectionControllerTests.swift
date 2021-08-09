@testable import SectionKit
import XCTest

internal final class SingleItemSectionControllerTests: XCTestCase {
    internal func testDidUpdateModelWithValidTypeSetsModel() {
        let sectionController = SingleItemSectionController<String, String>(model: "1")
        sectionController.didUpdate(model: "2")
        XCTAssertEqual(sectionController.model, "2")
    }

    internal func testDidUpdateModelWithInvalidType() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = SingleItemSectionController<String, String>(model: "1")
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

    internal func testInitDoesNotUpdateItemIfShouldNotUpdateItem() {
        class TestSectionController: SingleItemSectionController<String, String> {
            var itemsForModelExpectation: XCTestExpectation?

            init(model: String, itemsForModelExpectation: XCTestExpectation?) {
                self.itemsForModelExpectation = itemsForModelExpectation
                super.init(model: model, areItemsEqual: ==)
            }

            override func shouldUpdateItem(afterModelChangedTo model: String) -> Bool {
                false
            }

            override func item(for model: String) -> String? {
                itemsForModelExpectation?.fulfill()
                return nil
            }
        }
        let itemsForModelExpectation = expectation(description: "Should not invoke item(for:)")
        itemsForModelExpectation.fulfill()
        let _ = TestSectionController(model: "1", itemsForModelExpectation: itemsForModelExpectation)
        waitForExpectations(timeout: 1)
    }

    internal func testSettingModelDoesNotUpdateItemIfShouldNotUpdateItem() {
        class TestSectionController: SingleItemSectionController<String, String> {
            var itemsForModelExpectation: XCTestExpectation?

            init(model: String, itemsForModelExpectation: XCTestExpectation?) {
                self.itemsForModelExpectation = itemsForModelExpectation
                super.init(model: model, areItemsEqual: ==)
            }

            override func shouldUpdateItem(afterModelChangedTo model: String) -> Bool {
                false
            }

            override func item(for model: String) -> String? {
                itemsForModelExpectation?.fulfill()
                return nil
            }
        }
        let itemsForModelExpectation = expectation(description: "Should not invoke item(for:)")
        itemsForModelExpectation.fulfill()
        let sectionController = TestSectionController(model: "1", itemsForModelExpectation: nil)
        // set expectation after init so a possible bug in the init is not caught by this test
        sectionController.itemsForModelExpectation = itemsForModelExpectation
        sectionController.model = "2"
        waitForExpectations(timeout: 1)
    }

    internal func testShouldUpdateItemDefaultsToTrue() {
        let sectionController = SingleItemSectionController<String, String>(model: "1")
        XCTAssert(sectionController.shouldUpdateItem(afterModelChangedTo: "2"))
    }

    internal func testItemForModelInvokesNotImplementedError() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = SingleItemSectionController<String, String>(model: "1")
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
        XCTAssertEqual(sectionController.item(for: "2"), nil)
        waitForExpectations(timeout: 1)
    }

    internal func testCalculateUpdateFromSomeToSomeWithEqualItems() throws {
        let sectionController = SingleItemSectionController<String, Int>(model: "")
        let update = try XCTUnwrap(
            sectionController.calculateUpdate(
                from: 1,
                to: 1
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
    }

    internal func testCalculateUpdateFromSomeToSomeWithDifferentItems() throws {
        let sectionController = SingleItemSectionController<String, Int>(model: "")
        let update = try XCTUnwrap(
            sectionController.calculateUpdate(
                from: 1,
                to: 2
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssertEqual(batchOperation.reloads, [0])
        XCTAssert(batchOperation.moves.isEmpty)
    }

    internal func testCalculateUpdateFromNoneToSome() throws {
        let sectionController = SingleItemSectionController<String, Int>(model: "")
        let update = try XCTUnwrap(
            sectionController.calculateUpdate(
                from: nil,
                to: 1
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssertEqual(batchOperation.inserts, [0])
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
    }

    internal func testCalculateUpdateFromSomeToNone() throws {
        let sectionController = SingleItemSectionController<String, Int>(model: "")
        let update = try XCTUnwrap(
            sectionController.calculateUpdate(
                from: 1,
                to: nil
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssertEqual(batchOperation.deletes, [0])
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
    }

    internal func testCalculateUpdateFromNoneToNone() throws {
        let sectionController = SingleItemSectionController<String, Int>(model: "")
        let update = try XCTUnwrap(
            sectionController.calculateUpdate(
                from: nil,
                to: nil
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
    }

    internal func testNumberOfItemsWithItem() {
        let sectionController = SingleItemSectionController<String, String>(model: "1")
        sectionController.item = "1"
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(sectionController.numberOfItems(in: context), 1)
    }

    internal func testNumberOfItemsWithoutItem() {
        let sectionController = SingleItemSectionController<String, String>(model: "1")
        sectionController.item = nil
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(sectionController.numberOfItems(in: context), 0)
    }
}
