import SectionKit

internal class MockSectionController: SectionController {
    internal var context: CollectionViewContext?

    internal lazy var dataSource: SectionDataSource = { fatalError("datasource is not set") }()

    internal lazy var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? = {
        fatalError("dataSourcePrefetchingDelegate is not set")
    }()

    internal lazy var delegate: SectionDelegate? = { fatalError("delegate is not set") }()

    internal lazy var flowDelegate: SectionFlowDelegate? = { fatalError("flowDelegate is not set") }()

    internal lazy var dragDelegate: SectionDragDelegate? = { fatalError("dragDelegate is not set") }()

    internal lazy var dropDelegate: SectionDropDelegate? = { fatalError("dropDelegate is not set") }()

    internal lazy var errorHandler: ErrorHandling = { fatalError("errorHandler is not set") }()

    // MARK: - didUpdate

    internal typealias DidUpdateBlock = (Any) -> Void

    internal var _didUpdate: DidUpdateBlock = { _ in fatalError("not implemented") }

    internal func didUpdate(model: Any) {
        _didUpdate(model)
    }
}
