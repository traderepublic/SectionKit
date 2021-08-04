import SectionKit
import XCTest

internal final class BaseSectionControllerSectionDataSourceTests: BaseSectionDataSourceTests {
    override func createSectionDataSource() throws -> SectionDataSource {
        BaseSectionController()
    }
}
