import XCTest
@testable import SectionKit

final class SectionBatchOperationTests: XCTestCase {
    static var allTests = [
        "testDeletes": testDeletes,
        "testDeletes": testInserts,
        "testDeletes": testMoves,
        "testDeletes": testReloads,
    ]

    func testDeletes() {
        let input = SectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.deletes
        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }

    func testInserts() {
        let input = SectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.inserts
        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }

    func testMoves() {
        let input = SectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.moves

        let expected = Set([SectionBatchOperation<[Int]>.Move(at: 0, to: 1),
                            SectionBatchOperation<[Int]>.Move(at: 1, to: 2)])

        XCTAssertEqual(output, expected)
    }

    func testReloads() {
        let input = SectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.reloads

        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }
}

extension SectionBatchOperationTests {
    private var data: [Int] {
        [1,2,3]
    }

    private var changes: Set<SectionChange> {
        [
            .deleteItem(at: 0),
            .deleteItem(at: 1),
            .insertItem(at: 0),
            .insertItem(at: 1),
            .moveItem(at: 0, to: 1),
            .moveItem(at: 1, to: 2),
            .reloadItem(at: 0),
            .reloadItem(at: 1)
        ]
    }
}
