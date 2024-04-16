import SectionKit
import XCTest

final class BaseSectionControllerSectionFlowDelegateTests: BaseSectionFlowDelegateTests {
    @MainActor 
    override func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        BaseSectionController()
    }
}
