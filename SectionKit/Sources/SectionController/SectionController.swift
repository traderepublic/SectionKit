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

    /// The delegate for the `UICollectionViewFlowLayout` of this section.
    var flowDelegate: SectionFlowDelegate? { get }

    /// The drag delegate of this section.
    @available(iOS 11.0, *)
    var dragDelegate: SectionDragDelegate? { get }

    /// The drop delegate of this section.
    @available(iOS 11.0, *)
    var dropDelegate: SectionDropDelegate? { get }

    @available(iOS 13.0, *)
    var layoutProvider: SectionLayoutProvider? { get }

    /// The model of this section controller changed.
    func didUpdate(model: Any)
}

extension SectionController {
    @available(iOS 10.0, *)
    public var dataSourcePrefetchingDelegate: SectionDataSourcePrefetchingDelegate? { nil }

    public var delegate: SectionDelegate? { nil }

    public var flowDelegate: SectionFlowDelegate? { nil }

    @available(iOS 11.0, *)
    public var dragDelegate: SectionDragDelegate? { nil }

    @available(iOS 11.0, *)
    public var dropDelegate: SectionDropDelegate? { nil }

    @available(iOS 13.0, *)
    public var layoutProvider: SectionLayoutProvider? { nil }
}

@available(iOS 13.0, *)
public enum SectionLayoutProvider {
    case flowLayout(FlowLayoutProvider)
    case compositionalLayout(CompositionalLayoutProvider)
}

public typealias FlowLayoutProvider = SectionFlowDelegate

@MainActor
@available(iOS 13.0, *)
public struct CompositionalLayoutProvider {
    /// Provide the layout section for the Compositional Layout
    /// - Parameters:
    ///   - layoutEnvironment: the environment value for the layout
    /// - Returns: The layout for the section
    var layoutSection: (_ layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection

    public init(
        layoutSection: @escaping (any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
    ) {
        self.layoutSection = layoutSection
    }
}

@available(iOS 13.0, *)
public extension SectionLayoutProvider {
    var flowLayoutProvider: FlowLayoutProvider? {
        guard case .flowLayout(let flowLayoutProvider) = self else {
            return nil
        }
        return flowLayoutProvider
    }

    var compositionalLayoutProvider: CompositionalLayoutProvider? {
        guard case .compositionalLayout(let compositionalLayoutProvider) = self else {
            return nil
        }
        return compositionalLayoutProvider
    }
}
