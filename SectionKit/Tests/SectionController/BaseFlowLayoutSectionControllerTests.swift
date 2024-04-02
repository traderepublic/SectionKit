import SectionKit
import XCTest

internal final class BaseFlowLayoutSectionControllerTests: XCTestCase {
    @MainActor 
    internal func testFlowDelegateIsSelf() {
        let sectionController = BaseFlowLayoutSectionController()
        XCTAssert(sectionController.flowDelegate === sectionController)
    }
}
