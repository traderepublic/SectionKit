import UIKit
import SectionKit

final class ColorSectionController: ListSectionController<ColorViewModelType, UIColor> {
    override func items(for model: ColorViewModelType) -> [UIColor] {
        model.colors
    }

    override func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        let cell = context!.dequeueReusableCell(ColorCell.self, for: indexPath.indexInCollectionView)
        cell.color = items[indexPath.indexInSectionController]
        return cell
    }

    override func sizeForItem(at indexPath: SectionIndexPath, using layout: UICollectionViewLayout) -> CGSize {
        CGSize(width: context!.containerSize.width, height: 50)
    }

    override func didSelectItem(at indexPath: SectionIndexPath) {
        model.select(color: items[indexPath.indexInSectionController])
    }
}
