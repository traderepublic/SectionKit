import SectionKit
import XCTest

internal class MockSectionController: SectionController {
    internal var context: CollectionViewContext?

    internal lazy var dataSource: SectionDataSource = {
        XCTFail("datasource is not set")
        return MockSectionDataSource()
    }()

    @available(iOS 10.0, *)
    internal lazy var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? = {
        XCTFail("dataSourcePrefetchingDelegate is not set")
        return nil
    }()

    internal lazy var delegate: SectionDelegate? = {
        XCTFail("delegate is not set")
        return nil
    }()

    internal lazy var flowDelegate: SectionFlowDelegate? = {
        XCTFail("flow delegate is not set")
        return nil
    }()

    @available(iOS 11.0, *)
    internal lazy var dragDelegate: SectionDragDelegate? = {
        XCTFail("dragDelegate is not set")
        return nil
    }()

    @available(iOS 11.0, *)
    internal lazy var dropDelegate: SectionDropDelegate? = {
        XCTFail("dropDelegate is not set")
        return nil
    }()

    internal lazy var errorHandler: ErrorHandling = {
        XCTFail("errorHandler is not set")
        return AssertionFailureErrorHandler()
    }()

    // MARK: - didUpdate

    internal typealias DidUpdateBlock = (Any) -> Void

    internal lazy var _didUpdate: DidUpdateBlock = { _ in
        XCTFail("not implemented")
    }

    internal func didUpdate(model: Any) {
        _didUpdate(model)
    }
}
