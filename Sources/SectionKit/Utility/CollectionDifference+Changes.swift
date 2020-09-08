import Foundation

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension CollectionDifference {
    /// Convert this `CollectionDifference` to a set of collection changes
    @inlinable
    var collectionChanges: Set<CollectionChange> {
        var changes = Set<CollectionChange>()
        for change in self {
            switch change {
            case .insert(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveSection(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertSection(at: offset))
                }
            case .remove(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if associatedWith == nil {
                    changes.insert(.deleteSection(at: offset))
                }
            }
        }
        return changes
    }

    /// Convert this `CollectionDifference` to a set of section changes
    @inlinable
    var sectionChanges: Set<SectionChange> {
        var changes = Set<SectionChange>()
        for change in self {
            switch change {
            case .insert(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveItem(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertItem(at: offset))
                }
            case .remove(offset: let offset,
                         element: _,
                         associatedWith: let associatedWith):
                if associatedWith == nil {
                    changes.insert(.deleteItem(at: offset))
                }
            }
        }
        return changes
    }
}
