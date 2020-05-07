import UIKit

/// A controller for a section in a `UICollectionView`
public protocol SectionController: AnyObject {
    /// An object which provides contextual information of the `UICollectionView`
    var context: CollectionContext? { get set }
    
    /// The datasource of this section
    var dataSource: SectionDataSource { get }
    
    /// The delegate of this section
    var delegate: SectionDelegate? { get }
    
    /// The delegate for the `UICollectionViewFlowLayout` of this section
    var flowDelegate: SectionFlowDelegate? { get }
    
    /// The drag delegate of this section
    @available(iOS 11.0, *)
    var dragDelegate: SectionDragDelegate? { get }
    
    /// The drop delegate of this section
    @available(iOS 11.0, *)
    var dropDelegate: SectionDropDelegate? { get }
    
    func didUpdate(model: SectionModel)
}

public extension SectionController {
    var delegate: SectionDelegate? { nil }
    
    var flowDelegate: SectionFlowDelegate? { nil }
    
    @available(iOS 11.0, *)
    var dragDelegate: SectionDragDelegate? { nil }
    
    @available(iOS 11.0, *)
    var dropDelegate: SectionDropDelegate? { nil }
}

