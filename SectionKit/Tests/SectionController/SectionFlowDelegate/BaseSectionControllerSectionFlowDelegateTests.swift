import SectionKit
import XCTest

@MainActor
internal final class BaseSectionControllerSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseSectionController()
    }
}
