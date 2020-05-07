import Foundation
import SectionKit
import DifferenceKit

open class DiffingListSectionAdapter: ListSectionAdapter {
    override open func calculateUpdate(from oldData: [Section],
                                       to newData: [Section]) -> CollectionUpdate<[Section]> {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return CollectionUpdate(batchOperations: changeSet.map(\.collectionBatchOperation),
                                setData: { [weak self] in self?.collectionViewSections = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}
