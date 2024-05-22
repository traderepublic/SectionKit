import SectionKit
import XCTest

final class BaseSectionControllerSectionDataSourceTests: BaseSectionDataSourceTests {
    @MainActor
    override func createSectionDataSource() throws -> SectionDataSource {
        BaseSectionController()
    }
}
