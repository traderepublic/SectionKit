import SectionKit
import XCTest

internal final class BaseSectionControllerSectionDelegateTests: BaseSectionDelegateTests {
    override func createSectionDelegate() throws -> SectionDelegate {
        BaseSectionController()
    }
}
