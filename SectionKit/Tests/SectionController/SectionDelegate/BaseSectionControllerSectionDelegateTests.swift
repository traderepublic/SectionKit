import SectionKit
import XCTest

final class BaseSectionControllerSectionDelegateTests: BaseSectionDelegateTests {
    @MainActor
    override func createSectionDelegate() throws -> SectionDelegate {
        BaseSectionController()
    }
}
