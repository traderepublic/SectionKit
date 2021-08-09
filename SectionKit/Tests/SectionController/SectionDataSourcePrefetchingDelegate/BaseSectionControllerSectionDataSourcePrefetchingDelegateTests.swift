import SectionKit
import XCTest

@available(iOS 10.0, *)
internal final class BaseSectionControllerSectionDataSourcePrefetchingDelegateTests: BaseSectionDataSourcePrefetchingDelegateTests {
    override func createSectionDataSourcePrefetchingDelegate() throws -> SectionDataSourcePrefetchingDelegate {
        BaseSectionController()
    }
}
