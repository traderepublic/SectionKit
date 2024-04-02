import UIKit

/// This is a foundational implementation of `FlowLayoutSectionController`, implementing the flow layout delegate while inheriting from the `BaseSectionController`.
@MainActor
open class BaseFlowLayoutSectionController: BaseSectionController,
                                            SectionFlowDelegate,
                                            FlowLayoutSectionController {
    open var flowDelegate: SectionFlowDelegate? { self }

    // MARK: - SectionFlowDelegate

    open func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.itemSize ?? CGSize(width: 50, height: 50)
    }

    open func inset(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> UIEdgeInsets {
        (layout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }

    open func minimumLineSpacing(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 10
    }

    open func minimumInteritemSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        (layout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 10
    }

    open func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }

    open func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        (layout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
