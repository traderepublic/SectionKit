@testable import SectionKit
import XCTest

internal class SequenceUniqueTests: XCTestCase {
    internal struct Section: Equatable {
        internal let id: Int
        internal let data: Int
    }

    internal func testUniqueAlreadyUnique() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 1),
            Section(id: 3, data: 1)
        ]
        XCTAssertEqual(
            input.unique(by: \.id),
            input
        )
    }

    internal func testUniqueAllTheSame() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 1, data: 2),
            Section(id: 1, data: 3)
        ]
        XCTAssertEqual(
            input.unique(by: \.id),
            [Section(id: 1, data: 1)]
        )
    }

    internal func testUniqueSomeUniques() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 2),
            Section(id: 1, data: 3)
        ]
        XCTAssertEqual(
            input.unique(by: \.id),
            [
                Section(id: 1, data: 1),
                Section(id: 2, data: 2)
            ]
        )
    }
}
