import DifferenceKit
import Foundation
import SectionKit

/**
 A `CollectionViewAdapter` that contains a list of sections. Changes to that list will be checked
 for the difference to the current value and separate inserts/deletes/moves will be performed
 to update the `UICollectionView`.
 */
open class DiffingListCollectionViewAdapter: ListCollectionViewAdapter {
    override open func calculateUpdate(
        from oldData: [Section],
        to newData: [Section]
    ) -> CollectionViewUpdate<[Section]>? {
        let changeSet = StagedChangeset(source: oldData, target: newData)
        return CollectionViewUpdate(
            batchOperations: changeSet.map(\.collectionBatchOperation),
            setData: { self.collectionViewSections = $0 },
            shouldReload: { $0.count > 100 }
        )
    }
}
