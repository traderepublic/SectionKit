@testable import SectionKit
import XCTest

internal class CollectionExtensionsTests: XCTestCase {
    internal func testNonEmpty() {
        let input = [1]
        XCTAssertFalse(input.isEmpty)
    }

    internal func testEmpty() {
        let input: [Int] = []
        XCTAssert(input.isEmpty)
    }
}
