import Foundation

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension CollectionDifference {
    /// Create a set of `CollectionViewChange` containing updates to the list of sections in the `UICollectionView`.
    @inlinable
    public var collectionChanges: Set<CollectionViewChange> {
        var changes = Set<CollectionViewChange>()
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

    /**
     Create a set of `SectionChange` containing the difference to the list of items
     in a section in the `UICollectionView`.
     */
    @inlinable
    public var sectionChanges: Set<SectionChange> {
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
