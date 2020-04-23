import UIKit
import SectionKit

extension StockViewModel: CollectionViewCellRepresentable {
    func configure(cell: StockCell, at indexPath: SectionIndexPath, in context: CollectionContext) {
        cell.configure(with: self)
    }

    func sizeForItem(at indexPath: IndexPath,
                     using layout: UICollectionViewLayout,
                     in context: CollectionContext) -> CGSize {
        let width = context.insetContainerSize.width
        let height = CGFloat.greatestFiniteMagnitude
        let maxSize = CGSize(width: width, height: height)
        return StockCell.size(for: self, size: maxSize)
    }

    func didSelectItem(at indexPath: IndexPath, in context: CollectionContext) {
        context.collectionView.deselectItem(at: indexPath, animated: true)
        inputs.deletePressedObserver.send(value: ())
    }
}
