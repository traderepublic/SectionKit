@testable import SectionKit
import XCTest

internal class IndexPathIsValidTests: XCTestCase {
    internal func testInvalidIndexPath() {
        let indexPath = IndexPath()
        XCTAssertFalse(indexPath.isValid)
    }

    internal func testValidIndexPath() {
        let indexPath = IndexPath(item: 1, section: 2)
        XCTAssert(indexPath.isValid)
    }
}
