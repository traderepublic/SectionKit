import SectionKit
import XCTest

@available(iOS 10.0, *)
final class BaseSectionControllerSectionDataSourcePrefetchingDelegateTests: BaseSectionDataSourcePrefetchingDelegateTests {
    @MainActor
    override func createSectionDataSourcePrefetchingDelegate() throws -> SectionDataSourcePrefetchingDelegate {
        BaseSectionController()
    }
}
