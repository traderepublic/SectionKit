@testable import SectionKit
import XCTest

internal final class SectionBatchOperationTests: XCTestCase {
    private let data: [Int] = [
        1,
        2,
        3
    ]

    internal func testDeletes() {
        let input = CollectionViewSectionBatchOperation<[Int]>(data: data, deletes: [0, 1])
        XCTAssertEqual(input.deletes, [0, 1])
    }

    internal func testInserts() {
        let input = CollectionViewSectionBatchOperation<[Int]>(data: data, inserts: [0, 1])
        XCTAssertEqual(input.inserts, [0, 1])
    }

    internal func testMoves() {
        let moves: Set<Move> = [Move(at: 0, to: 1), Move(at: 1, to: 2)]
        let input = CollectionViewSectionBatchOperation<[Int]>(data: data, moves: moves)
        XCTAssertEqual(input.moves, moves)
    }

    internal func testReloads() {
        let input = CollectionViewSectionBatchOperation<[Int]>(data: data, reloads: [0, 1])
        XCTAssertEqual(input.reloads, [0, 1])
    }
}
