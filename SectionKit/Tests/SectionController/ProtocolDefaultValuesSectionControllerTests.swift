import SectionKit
import XCTest

@MainActor
internal final class ProtocolDefaultValuesSectionControllerTests: XCTestCase {
    private func createSectionController() -> SectionController {
        class DefaultSectionController: SectionController {
            var context: CollectionViewContext?
            var dataSource: SectionDataSource = MockSectionDataSource()
            func didUpdate(model: Any) { }
        }
        return DefaultSectionController()
    }

    @available(iOS 10.0, *)
    internal func testDataSourcePrefetchingDelegateIsNil() {
        let sectionController = createSectionController()
        XCTAssertNil(sectionController.dataSourcePrefetchingDelegate)
    }

    internal func testDelegateIsNil() {
        let sectionController = createSectionController()
        XCTAssertNil(sectionController.delegate)
    }

    internal func testFlowDelegateIsNil() {
        let sectionController = createSectionController()
        XCTAssertNil(sectionController.flowDelegate)
    }

    @available(iOS 11.0, *)
    internal func testDragDelegateIsNil() {
        let sectionController = createSectionController()
        XCTAssertNil(sectionController.dragDelegate)
    }

    @available(iOS 11.0, *)
    internal func testDropDelegateIsNil() {
        let sectionController = createSectionController()
        XCTAssertNil(sectionController.dropDelegate)
    }
}
