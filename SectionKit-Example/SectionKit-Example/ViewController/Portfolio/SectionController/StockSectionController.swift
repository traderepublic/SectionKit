import SectionKit
import DiffingSectionKit
import ReactiveCocoa
import ReactiveSwift
import UIKit

final class StockSectionController: DiffingSectionController<StockViewModel> {

    // MARK: - Properties

    let viewModel: StockSectionViewModel

    let (itemsMoved, itemsMovedObserver) = Signal<[StockViewModel], Never>.pipe()

    // MARK: - Initializer

    init(viewModel: StockSectionViewModel) {
        self.viewModel = viewModel
        super.init()
        reactive.items <~ viewModel.outputs.stocks
    }

    // MARK: - Drag

    override func dragItems(forBeginning session: UIDragSession,
                            at indexPath: SectionIndexPath) -> [UIDragItem] {
        let item = items[indexPath.internalRepresentation]
        let itemProvider = NSItemProvider(object: item.longName.value as NSString)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = item
        return [dragItem]
    }

    // MARK: - Drop

    override func canHandle(drop session: UIDropSession) -> Bool {
        return session.localDragSession?.items.allSatisfy { $0.localObject is StockViewModel } == true
    }

    override func dropSessionDidUpdate(_ session: UIDropSession,
                                       at indexPath: SectionIndexPath) -> UICollectionViewDropProposal {
        return UICollectionViewDropProposal(operation: .move,
                                            intent: .insertAtDestinationIndexPath)
    }

    func insert(_ item: StockViewModel, at index: Int) {
        var newItems = collectionViewItems
        newItems.insert(item, at: index)
        if let context = context {
            let batchOperation = SectionBatchOperation(changes: [.insertItem(at: index)],
                                                       data: newItems)
            let sectionUpdate = SectionUpdate(sectionId: id,
                                              batchOperations: [batchOperation],
                                              setData: { [weak self] in self?.collectionViewItems = $0 })
            context.apply(update: sectionUpdate)
        } else {
            collectionViewItems = newItems
        }
    }

    @discardableResult
    func remove(at index: Int) -> StockViewModel {
        var newItems = collectionViewItems
        let removedItem = newItems.remove(at: index)
        if let context = context {
            let batchOperation = SectionBatchOperation(changes: [.deleteItem(at: index)],
                                                       data: newItems)
            let sectionUpdate = SectionUpdate(sectionId: id,
                                              batchOperations: [batchOperation],
                                              setData: { [weak self] in self?.collectionViewItems = $0 })
            context.apply(update: sectionUpdate)
        } else {
            collectionViewItems = newItems
        }
        return removedItem
    }

    override func performDrop(at indexPath: SectionIndexPath,
                              with coordinator: UICollectionViewDropCoordinator) {
        var indexPath = indexPath
        switch coordinator.proposal.operation {
        case .move:
            for item in coordinator.items {
                guard
                    let itemViewModel = item.dragItem.localObject as? StockViewModel
                    else { continue }

                // Reorder ourself because DifferenceKit will calculate a move operation
                // But UICollectionView expects delete+insert when drag/dropping

                if
                    let sourceIndexPath = item.sourceIndexPath,
                    let (sourceSection, sourceSectionIndexPath) = context?.sectionControllerWithAdjustedIndexPath(for: sourceIndexPath),
                    let sourceStockSection = sourceSection as? StockSectionController
                {
                    sourceStockSection.remove(at: sourceSectionIndexPath.internalRepresentation)
                    if sourceStockSection.id != self.id {
                        sourceStockSection.itemsMovedObserver.send(value: sourceStockSection.items)
                    }
                }

                coordinator.drop(item.dragItem, toItemAt: indexPath.externalRepresentation)
                insert(itemViewModel, at: indexPath.internalRepresentation)
                itemsMovedObserver.send(value: items)

                indexPath = SectionIndexPath(externalRepresentation: IndexPath(item: indexPath.externalRepresentation.item + 1,
                                                                               section: indexPath.externalRepresentation.section),
                                             internalRepresentation: indexPath.internalRepresentation + 1)
            }
        default: return
        }
    }

    // MARK: - Header

    override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        guard
            let headerView = context?.dequeueReusableHeaderView(StockSectionHeaderView.self,
                                                                for: indexPath.externalRepresentation)
            else {
                assertionFailure("Failed to dequeue cell from updateDelegate")
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

// MARK: - StockViewModel+Differentiable

import DifferenceKit

extension StockViewModel: Differentiable {
    var differenceIdentifier: UUID { id }
}
