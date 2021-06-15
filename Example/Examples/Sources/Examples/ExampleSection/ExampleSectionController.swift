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
        let cell: ExampleCell = context.dequeueReusableCell(for: indexPath)
        cell.configure(with: items[indexPath])
        return cell
    }

    override internal func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        items[indexPath].didSelect()
    }

    override internal func headerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let headerView: ExampleSectionHeaderView = context.dequeueReusableHeaderView(for: indexPath)
        headerView.configure(with: model)
        return headerView
    }

    override internal func footerView(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionReusableView {
        let footerView: ExampleSectionFooterView = context.dequeueReusableFooterView(for: indexPath)
        footerView.configure(with: model)
        return footerView
    }
}
