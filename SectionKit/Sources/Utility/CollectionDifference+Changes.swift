import Foundation

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension CollectionDifference {
    /// Create a set of `CollectionViewChange` containing updates to the list of sections in the `UICollectionView`.
    @inlinable
    public var collectionViewChanges: Set<CollectionViewChange> {
        var changes = Set<CollectionViewChange>()
        for change in self {
            switch change {
            case let .insert(offset: offset, element: _, associatedWith: associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveSection(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertSection(at: offset))
                }

            case let .remove(offset: offset, element: _, associatedWith: associatedWith):
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
    public var sectionChanges: Set<CollectionViewSectionChange> {
        var changes = Set<CollectionViewSectionChange>()
        for change in self {
            switch change {
            case let .insert(offset: offset, element: _, associatedWith: associatedWith):
                if let associatedWith = associatedWith {
                    changes.insert(.moveItem(at: associatedWith, to: offset))
                } else {
                    changes.insert(.insertItem(at: offset))
                }

            case let .remove(offset: offset, element: _, associatedWith: associatedWith):
                if associatedWith == nil {
                    changes.insert(.deleteItem(at: offset))
                }
            }
        }
        return changes
    }
}