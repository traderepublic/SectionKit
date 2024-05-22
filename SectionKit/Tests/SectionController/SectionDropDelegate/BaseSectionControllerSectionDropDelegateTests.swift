import SectionKit
import XCTest

@available(iOS 11.0, *)
final class BaseSectionControllerSectionDropDelegateTests: BaseSectionDropDelegateTests {
    @MainActor
    override func createSectionDropDelegate() throws -> SectionDropDelegate {
        BaseSectionController()
    }
}
