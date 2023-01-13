import SectionKit
import XCTest

@MainActor
@available(iOS 11.0, *)
internal final class ProtocolDefaultValuesSectionDropDelegateTests: BaseSectionDropDelegateTests {
    override func createSectionDropDelegate() throws -> SectionDropDelegate {
        class DefaultSectionDropDelegate: SectionDropDelegate {
            func performDrop(
                at indexPath: SectionIndexPath?,
                with coordinator: UICollectionViewDropCoordinator,
                in context: CollectionViewContext
            ) { }
        }
        return DefaultSectionDropDelegate()
    }

    override func testPerformDrop() throws {
        throw XCTSkip("Protocol doesn't define default value for function")
    }
}
