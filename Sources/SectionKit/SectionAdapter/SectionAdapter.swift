import UIKit

/// The root object for a given `UICollectionView` that forwards datasource and delegate methods to the corresponding `SectionController`
public protocol SectionAdapter: AnyObject {
    /// An object providing contextual information
    var collectionContext: CollectionContext { get }
    
    /// A delegate that receives callbacks from the `UIScrollView`
    var scrollViewDelegate: UIScrollViewDelegate? { get set }
    
    /// Sections
    var sections: [Section] { get set }
    
    /// The datasource of this adapter responsible for creating `SectionControllers`
    var dataSource: SectionAdapterDataSource? { get set }
    
    /// If reordering should be allowed between different sections
    var allowReorderingBetweenDifferentSections: Bool { get set }
    
    /// Tells the adapter to query the `dataSource` again
    func invalidateDataSource()
}

// MARK: - Sample implementation

enum MySections: String {
    case first
    case second
}

class MyAdapterDataSource: SectionAdapterDataSource {
    func objects(for adapter: SectionAdapter) -> [SectionAdapterObject] {
        return [
            .section(id: MySections.first, model: ["1", "2"]),
            .section(id: MySections.second, model: ["3", "4"])
        ]
    }
    
    func sectionController(with model: AnyHashable, for adapter: SectionAdapter) -> SectionController {
        switch model {
        case let model as MySections:
            switch model {
            case .first:
                let sectionController = ListSectionController<String>(id: MySections.first.rawValue)
                sectionController.items = ["1", "2"]
                return sectionController
            case .second:
                let sectionController = ListSectionController<String>(id: MySections.second.rawValue)
                sectionController.items = ["3", "4"]
                return sectionController
            }
        default: fatalError("unsupported section model")
        }
    }
}
