@testable import SectionKit
import XCTest

internal final class SectionUpdateTests: XCTestCase {
    internal func testInitializeSectionUpdate() {
        let setData: ([Int]) -> Void = { _ in }

        let input = CollectionViewSectionUpdate<[Int]>(sectionId: "1", data: [1, 2, 3], setData: setData)

        let output1 = CollectionViewSectionUpdate<[Int]>(sectionId: "2", data: [1, 2, 3], setData: setData)
        let output2 = CollectionViewSectionUpdate<[Int]>(sectionId: "1", changes: [], data: [1, 2], setData: setData)
        let output3 = CollectionViewSectionUpdate<[Int]>(sectionId: "1",
                                                         changes: [],
                                                         data: [1, 2, 3],
                                                         setData: setData,
                                                         shouldReload: { _ in true })

        let output4 = CollectionViewSectionUpdate<[Int]>(sectionId: "1",
                                                         changes: [],
                                                         data: [1, 2, 3],
                                                         setData: setData,
                                                         shouldReload: { _ in true })

        let output5BatchOperations = [CollectionViewSectionBatchOperation(changes: [], data: [1, 2, 3])]
        let output5 = CollectionViewSectionUpdate<[Int]>(sectionId: "2",
                                                         batchOperations: output5BatchOperations,
                                                         setData: setData,
                                                         shouldReload: { _ in true })

        XCTAssertNotEqual(output1, input)
        XCTAssertNotEqual(output2, input)
        XCTAssertEqual(output3, input)
        XCTAssertEqual(output4, input)
        XCTAssertNotEqual(output5, input)
    }
}

extension CollectionViewSectionUpdate: Equatable where SectionData: Equatable {
    public static func == (lhs: CollectionViewSectionUpdate<SectionData>,
                           rhs: CollectionViewSectionUpdate<SectionData>) -> Bool {
        return lhs.sectionId == rhs.sectionId
            && lhs.batchOperations == rhs.batchOperations
    }
}

extension CollectionViewSectionBatchOperation: Equatable where SectionData: Equatable {
    public static func == (lhs: CollectionViewSectionBatchOperation<SectionData>,
                           rhs: CollectionViewSectionBatchOperation<SectionData>) -> Bool {
        return lhs.changes == rhs.changes
            && lhs.data == rhs.data
    }
}
