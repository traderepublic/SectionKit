@testable import SectionKit
import XCTest

internal final class SectionBatchOperationTests: XCTestCase {
    internal static var allTests = [
        "testEquatable": testEquatable,
        "testDeletes": testDeletes,
        "testInserts": testInserts,
        "testMoves": testMoves,
        "testReloads": testReloads
    ]

    private let data: [Int] = [
        1,
        2,
        3
    ]

    private let changes: Set<CollectionViewSectionChange> = [
        .deleteItem(at: 0),
        .deleteItem(at: 1),
        .insertItem(at: 0),
        .insertItem(at: 1),
        .moveItem(at: 0, to: 1),
        .moveItem(at: 1, to: 2),
        .reloadItem(at: 0),
        .reloadItem(at: 1)
    ]

    internal func testEquatable() {
        let input = CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data)
        XCTAssert(input == CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data))
    }

    internal func testDeletes() {
        let input = CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.deletes
        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }

    internal func testInserts() {
        let input = CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.inserts
        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }

    internal func testMoves() {
        let input = CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.moves

        let expected = Set([
            Move(at: 0, to: 1),
            Move(at: 1, to: 2)
        ])

        XCTAssertEqual(output, expected)
    }

    internal func testReloads() {
        let input = CollectionViewSectionBatchOperation<[Int]>(changes: changes, data: data)
        let output = input.reloads

        let expected = Set([0, 1])
        XCTAssertEqual(output, expected)
    }
}
