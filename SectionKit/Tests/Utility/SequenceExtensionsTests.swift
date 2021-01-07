@testable import SectionKit
import XCTest

internal class SequenceExtensionsTests: XCTestCase {
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

        let output = input.unique(by: { $0.id })
        XCTAssertEqual(output, input)
    }

    internal func testUniqueAllTheSame() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 1, data: 2),
            Section(id: 1, data: 3)
        ]

        let expectation = [
            Section(id: 1, data: 1)
        ]

        let output = input.unique(by: { $0.id })
        XCTAssertEqual(output, expectation)
    }

    internal func testUniqueSomeUniques() {
        let input = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 2),
            Section(id: 1, data: 3)
        ]

        let expectation = [
            Section(id: 1, data: 1),
            Section(id: 2, data: 2)
        ]

        let output = input.unique(by: { $0.id })
        XCTAssertEqual(output, expectation)
    }
}
