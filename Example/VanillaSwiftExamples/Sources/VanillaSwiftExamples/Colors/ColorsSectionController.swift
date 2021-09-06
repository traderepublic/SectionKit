import SectionKit
import UIKit

internal final class ColorsSectionController: ListSectionController<[UIColor], UIColor> {
    override internal func items(for model: [UIColor]) -> [UIColor] {
        model
    }

    override internal func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell: ColorCell = context.dequeueReusableCell(for: indexPath)
        cell.color = items[indexPath]
        return cell
    }

    override internal func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }

    override internal func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = items[indexPath]
        context.viewController?.navigationController?.pushViewController(viewController, animated: true)
    }
}
