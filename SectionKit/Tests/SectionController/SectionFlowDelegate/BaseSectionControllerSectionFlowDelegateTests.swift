import SectionKit
import XCTest

internal final class BaseSectionControllerSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseSectionController()
    }
}
