import UIKit

public protocol SectionAdapter: AnyObject {
    associatedtype DataSource: AdapterDataSource
    
    /// An object providing contextual information
    var collectionContext: CollectionContext { get }
    
    /// A delegate that receives callbacks from the `UIScrollView`
    var scrollViewDelegate: UIScrollViewDelegate? { get set }
    
    /// The datasource of this `SectionAdapter` responsible for creating `SectionControllers`
    var dataSource: DataSource { get set }
    
    /// If reordering should be allowed between different sections
    var allowReorderingBetweenDifferentSections: Bool { get set }
    
    /// Tells the `SectionAdapter` to query the `dataSource` when the data changed
    func invalidateDataSource()
}

public class AnyAdapterDataSource {
    
}

public protocol AdapterDataSource: AnyObject {
    associatedtype SectionIdentifier: Hashable
    
    /// Returns objects for each section.
    var objects: [AdapterObject<SectionIdentifier>] { get }
    
    /// Returns the `SectionController` for the provided object
    func sectionController(with identifier: SectionIdentifier,
                           items: [AnyHashable]) -> SectionController
}

public enum AdapterObject<SectionIdentifier: Hashable> {
    case section(identifier: SectionIdentifier, items: [AnyHashable])
}

// MARK: - Sample implementation

enum MySections: String {
    case first
    case second
}

class MyAdapterDataSource: AdapterDataSource {
    var objects: [AdapterObject<MySections>] {
        return [
            .section(identifier: .first, items: ["1", "2"]),
            .section(identifier: .second, items: ["3", "4"])
        ]
    }
    
    func sectionController(with identifier: SectionIdentifier,
                           items: [AnyHashable]) -> SectionController {
        switch identifier {
        case .first:
            let sectionController = ListSectionController<String>(id: identifier.rawValue)
            sectionController.items = items.map { $0 as! String }
            return sectionController
        case .second:
            let sectionController = ListSectionController<String>(id: identifier.rawValue)
            sectionController.items = items.map { $0 as! String }
            return sectionController
        }
    }
}
