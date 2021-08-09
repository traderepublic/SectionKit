import SectionKit
import XCTest

@available(iOS 10.0, *)
internal final class ProtocolDefaultValuesSectionDataSourcePrefetchingDelegateTests: BaseSectionDataSourcePrefetchingDelegateTests {
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
