import DifferenceKit
import Foundation

extension StagedChangeset {
    /**
     Returns an array of `ChangeSet<T>` where the `data` property is transformed using the given `transform` closure.
     
     - Parameter transform: A closure for transforming the `data` property.
     
     - Returns: An array of `ChangeSet<T>` where the `data` property is transformed using the given `transform` closure.
     */
    @inlinable
    public func mapData<T>(_ transform: (Collection.Element) throws -> T) rethrows -> [Changeset<[T]>] {
        return try map { changeSet -> Changeset<[T]> in
            Changeset(data: try changeSet.data.map(transform),
                      sectionDeleted: changeSet.sectionDeleted,
                      sectionInserted: changeSet.sectionInserted,
                      sectionUpdated: changeSet.sectionUpdated,
                      sectionMoved: changeSet.sectionMoved,
                      elementDeleted: changeSet.elementDeleted,
                      elementInserted: changeSet.elementInserted,
                      elementUpdated: changeSet.elementUpdated,
                      elementMoved: changeSet.elementMoved)
        }
    }
}
