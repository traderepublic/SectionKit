import SectionKit
import XCTest

@available(iOS 11.0, *)
internal final class BaseSectionControllerSectionDropDelegateTests: BaseSectionDropDelegateTests {
    override func createSectionDropDelegate() throws -> SectionDropDelegate {
        BaseSectionController()
    }
}
