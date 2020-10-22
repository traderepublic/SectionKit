@testable import SectionKit
import XCTest

internal final class SectionIndexPathTests: XCTestCase {
    internal func testInitializeSectionIndexPath() {
        let indexInCollectionView = IndexPath(item: 0, section: 1)
        let indexInSectionController = 0

        var input = SectionIndexPath(indexInCollectionView: indexInCollectionView,
                                     indexInSectionController: indexInSectionController)
        XCTAssertEqual(input.indexInCollectionView, indexInCollectionView)
        XCTAssertEqual(input.indexInSectionController, indexInSectionController)

        input = SectionIndexPath(indexInCollectionView)
        XCTAssertEqual(input.indexInCollectionView, indexInCollectionView)
        XCTAssertEqual(input.indexInSectionController, indexInSectionController)
    }
}
