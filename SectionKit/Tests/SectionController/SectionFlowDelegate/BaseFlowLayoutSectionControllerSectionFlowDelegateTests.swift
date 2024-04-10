import SectionKit
import XCTest

internal final class BaseSectionControllerSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    @MainActor 
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseSectionController()
    }
}
