import SectionKit
import XCTest

internal final class BaseFlowLayoutSectionControllerSectionFlowDelegateTests: BaseFlowLayoutSectionFlowDelegateTests {
    @MainActor 
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseFlowLayoutSectionController()
    }
}
