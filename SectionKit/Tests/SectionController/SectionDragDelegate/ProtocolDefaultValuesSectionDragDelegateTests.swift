import SectionKit
import XCTest

@available(iOS 11.0, *)
internal final class ProtocolDefaultValuesSectionDragDelegateTests: BaseSectionDragDelegateTests {
    override func createSectionDragDelegate() throws -> SectionDragDelegate {
        class DefaultSectionDragDelegate: SectionDragDelegate {
            func dragItems(
                forBeginning session: UIDragSession,
                at indexPath: SectionIndexPath,
                in context: CollectionViewContext
            ) -> [UIDragItem] {
                []
            }
        }
        return DefaultSectionDragDelegate()
    }

    override func testDragItemsForBeginning() throws {
        throw XCTSkip("Protocol doesn't define default value for function")
    }
}
