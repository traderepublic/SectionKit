import SectionKit
import UIKit
import XCTest

internal class MockSectionFlowDelegate: SectionFlowDelegate {
    // MARK: - sizeForItem

    internal typealias SizeForItemBlock = (SectionIndexPath, UICollectionViewLayout, CollectionViewContext) -> CGSize

    internal var _sizeForItem: SizeForItemBlock = { _, _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        _sizeForItem(indexPath, layout, context)
    }

    // MARK: - inset

    internal typealias InsetBlock = (UICollectionViewLayout, CollectionViewContext) -> UIEdgeInsets

    internal var _inset: InsetBlock = { _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func inset(using layout: UICollectionViewLayout, in context: CollectionViewContext) -> UIEdgeInsets {
        _inset(layout, context)
    }

    // MARK: - minimumLineSpacing

    internal typealias MinimumLineSpacingBlock = (UICollectionViewLayout, CollectionViewContext) -> CGFloat

    internal var _minimumLineSpacing: MinimumLineSpacingBlock = { _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func minimumLineSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        _minimumLineSpacing(layout, context)
    }

    // MARK: - minimumInteritemSpacing

    internal typealias MinimumInteritemSpacingBlock = (UICollectionViewLayout, CollectionViewContext) -> CGFloat

    internal var _minimumInteritemSpacing: MinimumInteritemSpacingBlock = { _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func minimumInteritemSpacing(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGFloat {
        _minimumInteritemSpacing(layout, context)
    }

    // MARK: - referenceSizeForHeader

    internal typealias ReferenceSizeForHeaderBlock = (UICollectionViewLayout, CollectionViewContext) -> CGSize

    internal var _referenceSizeForHeader: ReferenceSizeForHeaderBlock = { _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        _referenceSizeForHeader(layout, context)
    }

    // MARK: - referenceSizeForFooter

    internal typealias ReferenceSizeForFooterBlock = (UICollectionViewLayout, CollectionViewContext) -> CGSize

    internal var _referenceSizeForFooter: ReferenceSizeForFooterBlock = { _, _ in
        XCTFail("not implemented")
        return .zero
    }

    internal func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        _referenceSizeForFooter(layout, context)
    }
}
