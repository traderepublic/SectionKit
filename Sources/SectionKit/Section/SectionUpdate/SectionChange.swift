import Foundation

/// A single change made to the `UICollectionView`
public enum SectionChange: Hashable {
    /// Delete an item at the specified index
    case deleteItem(at: Int)

    /// Insert an item at the specified index
    case insertItem(at: Int)

    /// Reload an item at the specified index
    case reloadItem(at: Int)

    /// Move an item at the specified index
    case moveItem(at: Int, to: Int)
}
