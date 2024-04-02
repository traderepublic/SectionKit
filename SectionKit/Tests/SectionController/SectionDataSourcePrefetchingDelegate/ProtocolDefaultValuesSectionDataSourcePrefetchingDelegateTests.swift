import SectionKit
import XCTest

@available(iOS 10.0, *)
final class ProtocolDefaultValuesSectionDataSourcePrefetchingDelegateTests: BaseSectionDataSourcePrefetchingDelegateTests {
    @MainActor
    override func createSectionDataSourcePrefetchingDelegate() throws -> SectionDataSourcePrefetchingDelegate {
        class DefaultSectionDataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate {
            func prefetchItems(at indexPaths: [SectionIndexPath], in context: CollectionViewContext) { }
        }
        return DefaultSectionDataSourcePrefetchingDelegate()
    }

    override func testPrefetchItems() throws {
        throw XCTSkip("Protocol doesn't define default value for function")
    }
}
