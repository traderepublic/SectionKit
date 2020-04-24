import SectionKit
import DiffingSectionKit
import ReactiveCocoa
import ReactiveSwift
import UIKit

final class StockSectionController: DiffingSectionController<StockViewModel> {
    // MARK: - Properties
    let viewModel: StockSectionViewModel

    // MARK: - Initializer
    init(viewModel: StockSectionViewModel) {
        self.viewModel = viewModel
        super.init()
        reactive.items <~ viewModel.outputs.stocks
    }

    // MARK: - Header

    override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        guard let headerView = context?.dequeueReusableHeaderView(StockSectionHeaderView.self,
                                                                  for: indexPath.externalRepresentation) else {
                assertionFailure("Failed to dequeue cell from `context`")
                return UICollectionViewCell()
        }
        headerView.configure(with: viewModel)
        return headerView
    }

    override func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return CGSize(width: context.insetContainerSize.width, height: 50)
    }

}

//final class StockSectionController: DiffingSectionController<StockViewModel> {
//    // MARK: - Properties
//    let viewModel: StockSectionViewModel
//
//    // MARK: - Initializer
//    init(viewModel: StockSectionViewModel) {
//        self.viewModel = viewModel
//        super.init()
//        reactive.items <~ viewModel.outputs.stocks
//    }
//
//    @discardableResult
//    func remove(at index: Int) -> StockViewModel {
//        var newItems = collectionViewItems
//        let removedItem = newItems.remove(at: index)
//        if let context = context {
//            let batchOperation = SectionBatchOperation(changes: [.deleteItem(at: index)],
//                                                       data: newItems)
//            let sectionUpdate = SectionUpdate(sectionId: id,
//                                              batchOperations: [batchOperation],
//                                              setData: { [weak self] in self?.collectionViewItems = $0 })
//            context.apply(update: sectionUpdate)
//        } else {
//            collectionViewItems = newItems
//        }
//        return removedItem
//    }
//
//}
//
//// MARK: - StockViewModel+Differentiable
//

