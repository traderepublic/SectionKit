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
        layout.flowLayout?.itemSize ?? FlowLayoutConstants.defaultItemSize
    }

    open func inset(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> UIEdgeInsets {
        layout.flowLayout?.sectionInset ?? FlowLayoutConstants.defaultInset
    }

    open func minimumLineSpacing(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGFloat {
        layout.flowLayout?.minimumLineSpacing ?? FlowLayoutConstants.defaultMinimumLineSpacing
    }

    open func minimumInteritemSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        layout.flowLayout?.minimumInteritemSpacing ?? FlowLayoutConstants.defaultMinimumInteritemSpacing
    }

    open func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        layout.flowLayout?.headerReferenceSize ?? FlowLayoutConstants.defaultHeaderSize
    }

    open func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        layout.flowLayout?.footerReferenceSize ?? FlowLayoutConstants.defaultFooterSize
    }
}
