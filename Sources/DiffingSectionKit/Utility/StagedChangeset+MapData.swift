import DifferenceKit
import Foundation

public extension StagedChangeset {
    /**
     Returns an array of `ChangeSet<T>` where the `data` property is mapped using the given closure.
     
     - Parameter transform: A closure for mapping the `data` property.
     
     - Returns: An array of `ChangeSet<T>` where the `data` property is mapped using the given closure.
     */
    @inlinable
    func mapData<T>(_ transform: (Collection.Element) throws -> T) rethrows -> [Changeset<[T]>] {
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
