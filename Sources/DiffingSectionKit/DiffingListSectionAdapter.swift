import Foundation
import SectionKit
import DifferenceKit

open class DiffingListSectionAdapter: ListSectionAdapter {
    override open func calculateUpdate(from oldData: [SectionController],
                                       to newData: [SectionController]) -> CollectionUpdate<[SectionController]> {
        // wrap `SectionController`s inside `DifferentiableBox` for diffing
        // `SectionController` can't implement `Differentiable` directly,
        // otherwise it would have associatedtype constraints which makes it harder to use in some scenarios
        let oldSectionControllers = oldData.map {
            DifferentiableBox($0,
                              identifier: \.id,
                              equal: { $0 === $1 })
        }
        let newSectionControllers = newData.map {
            DifferentiableBox($0,
                              identifier: \.id,
                              equal: { $0 === $1 })
        }
        let changeSet = StagedChangeset(source: oldSectionControllers,
                                        target: newSectionControllers)
        let itemChangeSets = changeSet.mapData(\.item)
        return CollectionUpdate(batchOperations: itemChangeSets.map(\.collectionBatchOperation),
                                setData: { [weak self] in self?.collectionViewSectionControllers = $0 },
                                shouldReloadCollection: { $0.changes.count > 100 })
    }
}
