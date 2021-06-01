import SectionKit
import UIKit

internal final class ExampleSectionController: ListSectionController<
    ExampleSectionViewModelType,
    ExampleViewModelType
> {
    override internal func items(for model: ExampleSectionViewModelType) -> [ExampleViewModelType] {
        model.examples
    }

    override internal func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell: ExampleCell = context.dequeueReusableCell(for: indexPath.indexInCollectionView)
        cell.configure(with: items[indexPath.indexInSectionController])
        return cell
    }

    override internal func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width - 48, height: 50)
    }

    override internal func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        items[indexPath.indexInSectionController].didSelect()
    }

    // MARK: - Header

    override internal func headerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let headerView: ExampleSectionHeaderView = context.dequeueReusableHeaderView(for: indexPath.indexInCollectionView)
        headerView.configure(with: model)
        return headerView
    }

    override internal func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }

    // MARK: - Footer

    override internal func footerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let footerView: ExampleSectionFooterView = context.dequeueReusableFooterView(for: indexPath.indexInCollectionView)
        footerView.configure(with: model)
        return footerView
    }

    override internal func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        guard model.footer != nil else { return .zero }
        return CGSize(width: context.containerSize.width, height: 50)
    }
}
