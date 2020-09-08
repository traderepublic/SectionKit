import DifferenceKit
import Foundation
import SectionKit

/// A `ListCollectionViewAdapter` that performs diffing using `DifferenceKit`.
open class DiffingListCollectionViewAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionUpdate<[Section]> {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return CollectionUpdate(batchOperations: changeSet.map(\.collectionBatchOperation),
                                setData: { [weak self] in self?.collectionViewSections = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}
