@testable import SectionKit
import XCTest

internal final class SectionIndexPathTests: XCTestCase {
    internal func testInitWithIndexPath() {
        let indexPath = IndexPath(item: 0, section: 1)
        let sectionIndexPath = SectionIndexPath(indexPath)
        XCTAssertEqual(sectionIndexPath.indexInCollectionView, indexPath)
        XCTAssertEqual(sectionIndexPath.indexInSectionController, 0)
    }

    internal func testInitWithSeparateIndexAndIndexPath() {
        let indexPath = IndexPath(item: 0, section: 1)
        let index = 0
        let sectionIndexPath = SectionIndexPath(indexInCollectionView: indexPath, indexInSectionController: index)
        XCTAssertEqual(sectionIndexPath.indexInCollectionView, indexPath)
        XCTAssertEqual(sectionIndexPath.indexInSectionController, index)
    }
}
