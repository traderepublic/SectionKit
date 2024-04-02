import SectionKit
import XCTest

final class MockFlowLayoutSectionController: MockSectionController,
                                             FlowLayoutSectionController {
    lazy var flowDelegate: SectionFlowDelegate? = {
        XCTFail("flow delegate is not set")
        return nil
    }()
}
