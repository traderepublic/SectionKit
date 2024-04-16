import SectionKit
import XCTest

final class ProtocolDefaultValuesSectionControllerTests: XCTestCase {
    private var sut: SectionController!

    @MainActor
    override func setUp() {
        super.setUp()
        class DefaultSectionController: SectionController {
            var context: CollectionViewContext?
            var dataSource: SectionDataSource = MockSectionDataSource()
            func didUpdate(model: Any) { }
        }
        sut = DefaultSectionController()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    @MainActor
    @available(iOS 10.0, *)
    func testDataSourcePrefetchingDelegateIsNil() {
        XCTAssertNil(sut.dataSourcePrefetchingDelegate)
    }

    @MainActor
    func testDelegateIsNil() {
        XCTAssertNil(sut.delegate)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testDragDelegateIsNil() {
        XCTAssertNil(sut.dragDelegate)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testDropDelegateIsNil() {
        XCTAssertNil(sut.dropDelegate)
    }
}
