import XCTest
@testable import SectionKit

final class SectionUpdateTests: XCTestCase {
    func testInitializeSectionUpdate() {

        let setData: ([Int]) -> Void = { _ in }

        let input = SectionUpdate<[Int]>(sectionId: "1", data: [1,2,3], setData: setData)

        let output1 = SectionUpdate<[Int]>(sectionId: "2", data: [1,2,3], setData: setData)
        let output2 = SectionUpdate<[Int]>(sectionId: "1", changes: [], data: [1,2], setData: setData)
        let output3 = SectionUpdate<[Int]>(sectionId: "1", changes: [], data: [1,2,3], setData: setData, shouldReloadSection: { _ in true })

        let output4 = SectionUpdate<[Int]>(sectionId:"1",
                                           changes: [],
                                           data: [1,2,3],
                                           setData: setData,
                                           shouldReloadSection: { _ in true })

        let output5 = SectionUpdate<[Int]>(sectionId: "2",
                                           batchOperations: [SectionBatchOperation<[Int]>(changes: [], data: [1,2,3])],
                                           setData: setData,
                                           shouldReloadSection: { _ in true })


        XCTAssertNotEqual(output1, input)
        XCTAssertNotEqual(output2, input)
        XCTAssertEqual(output3, input)
        XCTAssertEqual(output4, input)
        XCTAssertNotEqual(output5, input)
    }
}
