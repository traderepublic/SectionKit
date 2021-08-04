import SectionKit
import XCTest

@available(iOS 11.0, *)
internal final class BaseSectionControllerSectionDragDelegateTests: BaseSectionDragDelegateTests {
    override func createSectionDragDelegate() throws -> SectionDragDelegate {
        BaseSectionController()
    }
}
