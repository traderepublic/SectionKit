import UIKit

extension UICollectionView {
    /**
     Reloads the specified section in the `UICollectionView` using the given update.
     
     - Parameter update: The update to apply to the specified section.
     
     - Parameter section: The section in the `UICollectionView` to modify.
     */
    @inlinable
    public func apply<T>(update: CollectionViewSectionUpdate<T>, at section: Int) {
        guard update.batchOperations.isNotEmpty else { return }

        if case .none = window, let data = update.batchOperations.last?.data {
            update.setData(data)
            return reloadSections(IndexSet(integer: section))
        }

        for batchOperation in update.batchOperations {
            performBatchUpdates({
                update.setData(batchOperation.data)

                if update.shouldReload(batchOperation) {
                    return reloadSections(IndexSet(integer: section))
                }

                let deletes = batchOperation.deletes
                if deletes.isNotEmpty {
                    deleteItems(at: deletes.map { IndexPath(item: $0, section: section) })
                }

                let inserts = batchOperation.inserts
                if inserts.isNotEmpty {
                    insertItems(at: inserts.map { IndexPath(item: $0, section: section) })
                }

                let moves = batchOperation.moves
                for move in moves {
                    moveItem(at: IndexPath(item: move.at, section: section),
                             to: IndexPath(item: move.to, section: section))
                }

                let reloads = batchOperation.reloads
                if reloads.isNotEmpty {
                    reloadItems(at: reloads.map { IndexPath(item: $0, section: section) })
                }
            }, completion: batchOperation.completion)
        }
    }

    /**
     Reloads the sections in the `UICollectionView` using the given update.
     
     - Parameter update: The update to apply to the sections.
     */
    @inlinable
    public func apply<T>(update: CollectionViewUpdate<T>) {
        guard update.batchOperations.isNotEmpty else { return }
        guard window != nil else {
            for batchOperation in update.batchOperations {
                update.setData(batchOperation.data)
                reloadData()
                batchOperation.completion?(false)
            }
            return
        }

        for batchOperation in update.batchOperations {
            performBatchUpdates({
                update.setData(batchOperation.data)

                if update.shouldReload(batchOperation) {
                    return reloadData()
                }

                let deletes = batchOperation.deletes
                if deletes.isNotEmpty {
                    deleteSections(IndexSet(deletes))
                }

                let inserts = batchOperation.inserts
                if inserts.isNotEmpty {
                    insertSections(IndexSet(inserts))
                }

                let moves = batchOperation.moves
                for move in moves {
                    moveSection(move.at, toSection: move.to)
                }

                let reloads = batchOperation.reloads
                if reloads.isNotEmpty {
                    reloadSections(IndexSet(reloads))
                }
            }, completion: batchOperation.completion)
        }
    }
}
