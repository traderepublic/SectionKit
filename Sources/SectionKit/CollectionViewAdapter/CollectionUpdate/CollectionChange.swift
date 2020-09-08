import Foundation

/// A single change made to the `UICollectionView`
public enum CollectionChange: Hashable {
    /// Delete a section at the specified index
    case deleteSection(at: Int)

    /// Insert a section at the specified index
    case insertSection(at: Int)

    /// Reload a section at the specified index
    case reloadSection(at: Int)

    /// Move a section at the specified index
    case moveSection(at: Int, to: Int)
}
