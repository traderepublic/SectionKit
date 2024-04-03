import UIKit

/// The delegate for the `UICollectionViewFlowLayout` of a section.
@MainActor
public protocol SectionFlowDelegate: AnyObject {
    /**
     Returns the size for the item at the given index path.
     
     - Parameter indexPath: The index path of the item of which the size should be calculated.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The size for the item at the given index path.
     */
    func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize

    /**
     Returns the inset of this section.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The inset of this section.
     */
    func inset(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> UIEdgeInsets

    /**
     Returns the minimum line spacing of this section.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The minimum line spacing of this section.
     */
    func minimumLineSpacing(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGFloat

    /**
     Returns the minimum inter-item spacing of this section.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The minimum inter-item spacing of this section.
     */
    func minimumInteritemSpacing(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGFloat

    /**
     Returns the size of a header view.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The size of a header view.
     */
    func referenceSizeForHeader(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGSize

    /**
     Returns the size of a footer view.
     
     - Parameter layout: The layout used to display the items.

     - Parameter context: The context the flow delegate is contained in.
     
     - Returns: The size of a footer view.
     */
    func referenceSizeForFooter(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGSize
}

enum FlowLayoutConstants {
    static let defaultItemSize = CGSize(width: 50, height: 50)
    static let defaultInset: UIEdgeInsets = .zero
    static let defaultMinimumLineSpacing: CGFloat = 10
    static let defaultMinimumInteritemSpacing: CGFloat = 10
    static let defaultHeaderSize: CGSize = .zero
    static let defaultFooterSize: CGSize = .zero
}

extension SectionFlowDelegate {
    public func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        layout.flowLayout?.itemSize ?? FlowLayoutConstants.defaultItemSize
    }

    public func inset(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> UIEdgeInsets {
        layout.flowLayout?.sectionInset ?? FlowLayoutConstants.defaultInset
    }

    public func minimumLineSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        layout.flowLayout?.minimumLineSpacing ?? FlowLayoutConstants.defaultMinimumLineSpacing
    }

    public func minimumInteritemSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        layout.flowLayout?.minimumInteritemSpacing ?? FlowLayoutConstants.defaultMinimumInteritemSpacing
    }

    public func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        layout.flowLayout?.headerReferenceSize ?? FlowLayoutConstants.defaultHeaderSize
    }

    public func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        layout.flowLayout?.footerReferenceSize ?? FlowLayoutConstants.defaultFooterSize
    }
}

extension UICollectionViewLayout {
    var flowLayout: UICollectionViewFlowLayout? {
        self as? UICollectionViewFlowLayout
    }
}
