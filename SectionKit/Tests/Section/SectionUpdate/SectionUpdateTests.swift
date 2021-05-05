@testable import SectionKit
import XCTest

internal final class SectionUpdateTests: XCTestCase {
    internal func testInitializeSectionUpdate() {
        let setData: ([Int]) -> Void = { _ in }

        let firstController = BaseSectionController()
        let secondController = BaseSectionController()

        let input = CollectionViewSectionUpdate<[Int]>(
            controller: firstController,
            data: [1, 2, 3],
            setData: setData
        )

        let output1 = CollectionViewSectionUpdate<[Int]>(
            controller: secondController,
            data: [1, 2, 3],
            setData: setData
        )
        let output2 = CollectionViewSectionUpdate<[Int]>(
            controller: firstController,
            data: [1, 2],
            setData: setData
        )
        let output3 = CollectionViewSectionUpdate<[Int]>(
            controller: firstController,
            data: [1, 2, 3],
            setData: setData,
            shouldReload: { _ in true }
        )

        let output4 = CollectionViewSectionUpdate<[Int]>(
            controller: firstController,
            data: [1, 2, 3],
            setData: setData,
            shouldReload: { _ in true }
        )

        let output5BatchOperations = [CollectionViewSectionBatchOperation(data: [1, 2, 3])]
        let output5 = CollectionViewSectionUpdate<[Int]>(
            controller: secondController,
            batchOperations: output5BatchOperations,
            setData: setData,
            shouldReload: { _ in true }
        )

        XCTAssertNotEqual(output1, input)
        XCTAssertNotEqual(output2, input)
        XCTAssertEqual(output3, input)
        XCTAssertEqual(output4, input)
        XCTAssertNotEqual(output5, input)
    }
}

extension CollectionViewSectionUpdate: Equatable where SectionData: Equatable {
    public static func == (
        lhs: CollectionViewSectionUpdate<SectionData>,
        rhs: CollectionViewSectionUpdate<SectionData>
    ) -> Bool {
        lhs.controller === rhs.controller
            && lhs.batchOperations == rhs.batchOperations
    }
}

extension CollectionViewSectionBatchOperation: Equatable where SectionData: Equatable {
    public static func == (
        lhs: CollectionViewSectionBatchOperation<SectionData>,
        rhs: CollectionViewSectionBatchOperation<SectionData>
    ) -> Bool {
        lhs.data == rhs.data
            && lhs.deletes == rhs.deletes
            && lhs.inserts == rhs.inserts
            && lhs.moves == rhs.moves
            && lhs.reloads == rhs.reloads
    }
}
