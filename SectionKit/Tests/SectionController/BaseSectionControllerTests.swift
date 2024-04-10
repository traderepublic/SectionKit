import SectionKit
import XCTest

@MainActor
internal final class BaseSectionControllerTests: XCTestCase {
    internal func testContextIsNil() {
        let sectionController = BaseSectionController()
        XCTAssertNil(sectionController.context)
    }

    internal func testDataSourceIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dataSource === sectionController)
    }

    @available(iOS 10.0, *)
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

    @available(iOS 11.0, *)
    internal func testDragDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dragDelegate === sectionController)
    }

    @available(iOS 11.0, *)
    internal func testDropDelegateIsSelf() {
        let sectionController = BaseSectionController()
        XCTAssert(sectionController.dropDelegate === sectionController)
    }

    internal func testDidUpdateModelDoesNothing() {
        let sectionController = BaseSectionController()
        sectionController.didUpdate(model: "")
    }
}
