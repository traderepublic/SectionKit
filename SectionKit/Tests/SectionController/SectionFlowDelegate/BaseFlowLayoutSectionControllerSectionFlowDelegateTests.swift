import SectionKit
import XCTest

final class BaseFlowLayoutSectionControllerSectionFlowDelegateTests: BaseFlowLayoutSectionFlowDelegateTests {
    @MainActor 
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseSectionController()
    }
}
