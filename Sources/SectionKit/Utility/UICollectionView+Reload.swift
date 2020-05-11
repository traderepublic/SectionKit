import UIKit

public extension UICollectionView {
    /**
     Reloads the specified section in the `UICollectionView` using the given update.
     
     - Parameter update: The update to apply to the specified section.
     
     - Parameter section: The section in the `UICollectionView` to modify.
     */
    func reload<T>(using update: SectionUpdate<T>,
                   at section: Int) {
        if case .none = window, let data = update.batchOperations.last?.data {
            update.setData(data)
            return reloadSections(IndexSet(integer: section))
        }
        
        for batchOperation in update.batchOperations {
            if update.shouldReloadSection(batchOperation) {
                update.setData(batchOperation.data)
                return reloadSections(IndexSet(integer: section))
            }
            performBatchUpdates({
                update.setData(batchOperation.data)
                
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
    func reload<T>(using update: CollectionUpdate<T>) {
        if case .none = window, let data = update.batchOperations.last?.data {
            update.setData(data)
            return reloadData()
        }
        
        for batchOperation in update.batchOperations {
            if update.shouldReloadCollection(batchOperation) {
                update.setData(batchOperation.data)
                return reloadData()
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
                for (at, to) in moves {
                    moveSection(at, toSection: to)
                }
                
                let reloads = batchOperation.reloads
                if reloads.isNotEmpty {
                    reloadSections(IndexSet(reloads))
                }
            }, completion: batchOperation.completion)
        }
    }
}

