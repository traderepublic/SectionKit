import ReactiveCocoa
import ReactiveSwift
import SectionKit
import UIKit
import Utilities

internal final class EmojisSectionController: BindingListSectionController<EmojisViewModelType, String> {
    override internal func bind() -> Disposable? {
        reactive[\.items] <~ model.emojis.map { $0.map(\.emoji) }
    }

    override internal func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell: LabelCell = context.dequeueReusableCell(for: indexPath)
        cell.label.text = items[indexPath.indexInSectionController]
        return cell
    }

    override internal func sizeForItem(
        at indexPath: SectionIndexPath,
        using layout: UICollectionViewLayout,
        in context: CollectionViewContext
    ) -> CGSize {
        CGSize(width: 100, height: 100)
    }

    override internal func shouldHighlightItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    override internal func shouldSelectItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }
}
