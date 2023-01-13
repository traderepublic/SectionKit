import SectionKit
import XCTest

@MainActor
internal final class ProtocolDefaultValuesSectionDataSourceTests: BaseSectionDataSourceTests {
    override func createSectionDataSource() throws -> SectionDataSource {
        class DefaultSectionDataSource: SectionDataSource {
            func numberOfItems(in context: CollectionViewContext) -> Int {
                0
            }
            func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
                UICollectionViewCell()
            }
        }
        return DefaultSectionDataSource()
    }

    override func testNumberOfItems() throws {
        throw XCTSkip("Protocol doesn't define default value for function")
    }

    override func testCellForItem() throws {
        throw XCTSkip("Protocol doesn't define default value for function")
    }
}
