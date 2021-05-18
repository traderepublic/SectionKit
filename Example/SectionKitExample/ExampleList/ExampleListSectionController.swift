import UIKit
import SectionKit

final class ExampleListSectionController: ListSectionController<ExampleListSectionViewModelType, ExampleViewModelType> {
    override func items(for model: ExampleListSectionViewModelType) -> [ExampleViewModelType] {
        model.examples
    }

    override func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell = context.dequeueReusableCell(ExampleCell.self, for: indexPath.indexInCollectionView)
        cell.configure(with: items[indexPath.indexInSectionController])
        return cell
    }

    override func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width - 48, height: 50)
    }

    override func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        items[indexPath.indexInSectionController].didSelect()
    }

    // MARK: - Header

    override func headerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let headerView = context.dequeueReusableHeaderView(ExampleListHeaderView.self, for: indexPath.indexInCollectionView)
        headerView.configure(with: model)
        return headerView
    }

    override func referenceSizeForHeader(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }

    // MARK: - Footer

    override func footerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let footerView = context.dequeueReusableFooterView(ExampleListFooterView.self, for: indexPath.indexInCollectionView)
        footerView.configure(with: model)
        return footerView
    }

    override func referenceSizeForFooter(
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        guard model.footer != nil else { return .zero }
        return CGSize(width: context.containerSize.width, height: 50)
    }
}
