import SectionKit
import XCTest

final class BaseSectionControllerTests: XCTestCase {
    @MainActor
    func testContextIsNil() {
        let sectionController = BaseSectionController()
        XCTAssertNil(sectionController.context)
    }

    @MainActor
    func testDataSourceIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dataSource === sectionController)
    }

    @MainActor
    @available(iOS 10.0, *)
    func testDataSourcePrefetchingDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dataSourcePrefetchingDelegate === sectionController)
    }

    @MainActor
    func testDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.delegate === sectionController)
    }

    @MainActor
    func testFlowDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.flowDelegate === sectionController)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testDragDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dragDelegate === sectionController)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testDropDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dropDelegate === sectionController)
    }

    @MainActor
    func testDidUpdateModelDoesNothing() {
        let sectionController = BaseSectionController()
        sectionController.didUpdate(model: "")
    }
}
