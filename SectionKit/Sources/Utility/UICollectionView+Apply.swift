import UIKit

extension UICollectionView {
    /**
     Update the specified section in the `UICollectionView` using the given update.
     
     - Parameter update: The update to apply to the specified section.
     
     - Parameter section: The index of the section in the `UICollectionView` which should be modified.
     */
    @inlinable
    public func apply<T>(update: CollectionViewSectionUpdate<T>, at section: Int) {
        guard update.batchOperations.isNotEmpty else {
            return
        }

        // reload data when the collection wasn't added to a window yet
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
                    return reloadSections(IndexSet(integer: section))
                }

                let deletes = batchOperation.deletes
                if deletes.isNotEmpty {
                    deleteItems(at: deletes.sorted(by: >).map { IndexPath(item: $0, section: section) })
                }

                let inserts = batchOperation.inserts
                if inserts.isNotEmpty {
                    insertItems(at: inserts.sorted(by: <).map { IndexPath(item: $0, section: section) })
                }

                let moves = batchOperation.moves
                for move in moves {
                    moveItem(
                        at: IndexPath(item: move.at, section: section),
                        to: IndexPath(item: move.to, section: section)
                    )
                }

                let reloads = batchOperation.reloads
                if reloads.isNotEmpty {
                    reloadItems(at: reloads.map { IndexPath(item: $0, section: section) })
                }
            }, completion: batchOperation.completion)
        }
    }

    /**
     Update the list of sections in the `UICollectionView` using the given update.
     
     - Parameter update: The update to apply to the list of sections.
     */
    @inlinable
    public func apply<T>(update: CollectionViewUpdate<T>) {
        guard update.batchOperations.isNotEmpty else {
            return
        }

        // reload data when the collection wasn't added to a window yet
        guard window != nil else {
            for batchOperation in update.batchOperations {
                update.setData(batchOperation.data)
                reloadData()
                batchOperation.completion?(false)
            }
            return
        }

        for batchOperation in update.batchOperations {
            if update.shouldReload(batchOperation) {
                update.setData(batchOperation.data)
                reloadData()
                batchOperation.completion?(false)
                continue
            }
            performBatchUpdates({
                update.setData(batchOperation.data)

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
