@testable import SectionKit
import XCTest

internal final class CollectionViewSectionBatchOperationTests: XCTestCase {
    internal func testCount() {
        let operation = CollectionViewSectionBatchOperation(
            data: "",
            deletes: [0],
            inserts: [1, 2],
            moves: [Move(at: 3, to: 4), Move(at: 4, to: 5), Move(at: 5, to: 6), Move(at: 6, to: 7)],
            reloads: [8, 9, 10, 11, 12, 13, 14, 15],
            completion: nil
        )
        XCTAssertEqual(operation.count, 15)
    }
}
