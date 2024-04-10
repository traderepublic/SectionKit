@testable import SectionKit
import XCTest

final class SingleModelSectionControllerTests: XCTestCase {
    @MainActor
    func testDidUpdateModelWithValidTypeSetsModel() {
        let sectionController = SingleModelSectionController(model: "1")
        sectionController.didUpdate(model: "2")
        XCTAssertEqual(sectionController.model, "2")
    }

    @MainActor
    func testDidUpdateModelWithInvalidType() {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionController = SingleModelSectionController(model: "1")
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error, severity in
                guard case let .sectionControllerModelTypeMismatch(expected, actual) = error else {
                    XCTFail("The error should be sectionControllerModelTypeMismatch")
                    return
                }
                XCTAssert(expected == String.self)
                XCTAssert(actual == Int.self)
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        sectionController.context = context
        sectionController.didUpdate(model: 2)
        XCTAssertEqual(sectionController.model, "1")
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCalculateUpdateFromSomeToSomeWithDifferentItems() throws {
        let sectionController = SingleModelSectionController<Int>(model: 1)
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
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssert(update.shouldReload(batchOperation))
    }

    @MainActor
    func testNumberOfItems() {
        let sectionController = SingleModelSectionController(model: "1")
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(sectionController.numberOfItems(in: context), 1)
    }
}
