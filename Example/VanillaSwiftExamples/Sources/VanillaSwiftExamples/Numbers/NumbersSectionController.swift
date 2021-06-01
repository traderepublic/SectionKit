import UIKit
import SectionKit

internal final class NumbersSectionController: ListSectionController<NumbersSectionViewModelType, Int> {
    override internal func items(for model: NumbersSectionViewModelType) -> [Int] {
        model.numbers
    }

    override internal func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell: NumberCell = context.dequeueReusableCell(for: indexPath.indexInCollectionView)
        cell.number = items[indexPath.indexInSectionController]
        return cell
    }

    override internal func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: 100, height: 100)
    }

    override internal func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        model.select(number: items[indexPath.indexInSectionController])
        context.collectionView.deselectItem(at: indexPath.indexInCollectionView, animated: true)
    }
}
