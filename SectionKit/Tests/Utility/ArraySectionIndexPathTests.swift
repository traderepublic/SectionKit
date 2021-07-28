@testable import SectionKit
import XCTest

internal class ArraySectionIndexPathTests: XCTestCase {
    internal func testGet() {
        let indexPath = IndexPath(item: 1, section: 0)
        let sectionIndexPath = SectionIndexPath(indexPath)
        let input = [1, 2, 3]
        XCTAssertEqual(input[sectionIndexPath], 2)
    }

    internal func testSet() {
        let indexPath = IndexPath(item: 1, section: 0)
        let sectionIndexPath = SectionIndexPath(indexPath)
        var input = [1, 2, 3]
        input[sectionIndexPath] = 5
        XCTAssertEqual(input, [1, 5, 3])
    }
}
