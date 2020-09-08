import UIKit

/// The delegate for the `UICollectionViewFlowLayout` of a section.
public protocol SectionFlowDelegate: AnyObject {
    /**
     Returns the size for the item at the given index path.
     
     - Parameter indexPath: The index path of the item of which the size should be calculated.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The size for the item at the given index path.
     */
    func sizeForItem(at indexPath: SectionIndexPath, using layout: UICollectionViewLayout) -> CGSize

    /**
     Returns the inset of this section.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The inset of this section.
     */
    func inset(using layout: UICollectionViewLayout) -> UIEdgeInsets

    /**
     Returns the minimum line spacing of this section.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The minimum line spacing of this section.
     */
    func minimumLineSpacing(using layout: UICollectionViewLayout) -> CGFloat

    /**
     Returns the minimum inter-item spacing of this section.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The minimum inter-item spacing of this section.
     */
    func minimumInteritemSpacing(using layout: UICollectionViewLayout) -> CGFloat

    /**
     Returns the size of a header view.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The size of a header view.
     */
    func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize

    /**
     Returns the size of a footer view.
     
     - Parameter layout: The layout used to display the items.
     
     - Returns: The size of a footer view.
     */
    func referenceSizeForFooter(using layout: UICollectionViewLayout) -> CGSize
}

public extension SectionFlowDelegate {
    func sizeForItem(at indexPath: SectionIndexPath,
                     using layout: UICollectionViewLayout) -> CGSize {
        return (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
    }

    func inset(using layout: UICollectionViewLayout) -> UIEdgeInsets {
        return (layout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    func minimumLineSpacing(using layout: UICollectionViewLayout) -> CGFloat {
        return (layout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 10
    }

    func minimumInteritemSpacing(using layout: UICollectionViewLayout) -> CGFloat {
        return (layout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
    }

    func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        return (layout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    func referenceSizeForFooter(using layout: UICollectionViewLayout) -> CGSize {
        return (layout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
