import SectionKit
import XCTest

@MainActor
internal final class BaseSectionControllerSectionDelegateTests: BaseSectionDelegateTests {
    override func createSectionDelegate() throws -> SectionDelegate {
        BaseSectionController()
    }
}
