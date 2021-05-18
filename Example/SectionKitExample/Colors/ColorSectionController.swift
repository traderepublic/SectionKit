import UIKit
import SectionKit

final class ColorSectionController: ListSectionController<ColorViewModelType, UIColor> {
    override func items(for model: ColorViewModelType) -> [UIColor] {
        model.colors
    }

    override func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell = context.dequeueReusableCell(ColorCell.self, for: indexPath.indexInCollectionView)
        cell.color = items[indexPath.indexInSectionController]
        return cell
    }

    override func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }

    override func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        model.select(color: items[indexPath.indexInSectionController])
    }
}
