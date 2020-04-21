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
                for change in batchOperation.changes {
                    switch change {
                    case .reloadSection:
                        reloadSections(IndexSet(integer: section))
                    case .deleteItem(at: let at):
                        deleteItems(at: [IndexPath(item: at, section: section)])
                    case .insertItem(at: let at):
                        insertItems(at: [IndexPath(item: at, section: section)])
                    case .reloadItem(at: let at):
                        reloadItems(at: [IndexPath(item: at, section: section)])
                    case .moveItem(at: let at, to: let to):
                        moveItem(at: IndexPath(item: at, section: section),
                                 to: IndexPath(item: to, section: section))
                    case .custom(let handler):
                        handler()
                    }
                }
            })
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
                for change in batchOperation.changes {
                    switch change {
                    case .reloadCollection:
                        reloadData()
                    case .deleteSection(at: let at):
                        deleteSections(IndexSet(integer: at))
                    case .insertSection(at: let at):
                        insertSections(IndexSet(integer: at))
                    case .reloadSection(at: let at):
                        reloadSections(IndexSet(integer: at))
                    case .moveSection(at: let at, to: let to):
                        moveSection(at, toSection: to)
                    case .custom(let handler):
                        handler()
                    }
                }
            })
        }
    }
}

