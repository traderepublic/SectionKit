import UIKit

/// A controller for a section in a `UICollectionView`.
@MainActor
public protocol SectionController: AnyObject {
    /// A context which provides contextual information for a `SectionController`.
    var context: CollectionViewContext? { get set }

    /// The datasource of this section.
    var dataSource: SectionDataSource { get }

    /// The prefetching delegate of the datasource of this section.
    @available(iOS 10.0, *)
    var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? { get }

    /// The delegate of this section.
    var delegate: SectionDelegate? { get }

    /// The drag delegate of this section.
    @available(iOS 11.0, *)
    var dragDelegate: SectionDragDelegate? { get }

    /// The drop delegate of this section.
    @available(iOS 11.0, *)
    var dropDelegate: SectionDropDelegate? { get }

    /// The model of this section controller changed.
    func didUpdate(model: Any)
}

extension SectionController {
    @available(iOS 10.0, *)
    public var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? { nil }

    public var delegate: SectionDelegate? { nil }

    @available(iOS 11.0, *)
    public var dragDelegate: SectionDragDelegate? { nil }

    @available(iOS 11.0, *)
    public var dropDelegate: SectionDropDelegate? { nil }
}

@MainActor
public protocol FlowLayoutSectionController: SectionController {
    /// The delegate for the `UICollectionViewFlowLayout` of this section.
    var flowDelegate: SectionFlowDelegate? { get }
}
