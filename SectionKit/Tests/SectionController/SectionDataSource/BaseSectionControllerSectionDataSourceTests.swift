import SectionKit
import XCTest

@MainActor
internal final class BaseSectionControllerSectionDataSourceTests: BaseSectionDataSourceTests {
    override func createSectionDataSource() throws -> SectionDataSource {
        BaseSectionController()
    }
}
