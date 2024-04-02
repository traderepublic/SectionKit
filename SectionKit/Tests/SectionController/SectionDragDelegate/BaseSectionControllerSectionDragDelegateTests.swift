import SectionKit
import XCTest

@available(iOS 11.0, *)
final class BaseSectionControllerSectionDragDelegateTests: BaseSectionDragDelegateTests {
    @MainActor
    override func createSectionDragDelegate() throws -> SectionDragDelegate {
        BaseSectionController()
    }
}
