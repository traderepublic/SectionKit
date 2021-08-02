@testable import SectionKit
import XCTest

internal class SequenceGroupTests: XCTestCase {
    internal struct Section: Equatable {
        internal let id: Int
        internal let data: Int
    }

    internal func testGroupUniqueArray() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 1),
            Section(id: 3, data: 1)
        ]
        XCTAssertEqual(
            input.group(by: \.id),
            [
                1: [Section(id: 1, data: 1)],
                2: [Section(id: 2, data: 1)],
                3: [Section(id: 3, data: 1)]
            ]
        )
    }

    internal func testUniqueAllTheSame() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 1, data: 2),
            Section(id: 1, data: 3)
        ]
        XCTAssertEqual(
            input.group(by: \.id),
            [
                1: input
            ]
        )
    }

    internal func testUniqueSomeUniques() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 2),
            Section(id: 1, data: 3)
        ]
        XCTAssertEqual(
            input.group(by: \.id),
            [
                1: [
                    Section(id: 1, data: 1),
                    Section(id: 1, data: 3)
                ],
                2: [Section(id: 2, data: 2)]
            ]
        )
    }
}
