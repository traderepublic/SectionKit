@testable import SectionKit
import XCTest

internal final class SectionIndexPathTests: XCTestCase {
    internal func testInitializeSectionIndexPath() {
        let externalRepresentation = IndexPath(item: 0, section: 1)
        let internalRepresentation = 0

        var input = SectionIndexPath(externalRepresentation: externalRepresentation,
                                     internalRepresentation: internalRepresentation)
        XCTAssertEqual(input.externalRepresentation, externalRepresentation)
        XCTAssertEqual(input.internalRepresentation, internalRepresentation)

        input = SectionIndexPath(externalRepresentation)
        XCTAssertEqual(input.externalRepresentation, externalRepresentation)
        XCTAssertEqual(input.internalRepresentation, internalRepresentation)
    }
}
