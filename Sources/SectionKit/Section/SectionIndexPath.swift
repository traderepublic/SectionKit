import Foundation

/// A struct containing the internal and external index of an item.
public struct SectionIndexPath {
    /// The index path of the item in the `UICollectionView`.
    public let externalRepresentation: IndexPath

    /// The internal index of the item.
    public let internalRepresentation: Int

    /**
     Initialize an instance of `SectionIndexPath`.

     - Parameter externalRepresentation: The index path of the item in the `UICollectionView`.

     - Parameter internalRepresentation: The internal index of the item.
     */
    public init(externalRepresentation: IndexPath, internalRepresentation: Int) {
        self.externalRepresentation = externalRepresentation
        self.internalRepresentation = internalRepresentation
    }
}

extension SectionIndexPath {
    /**
     Initialize an instance of `SectionIndexPath`.

     - Parameter externalRepresentation: The index path of the item in the `UICollectionView`.

     - Parameter internalRepresentation: The internal index of the item.
     */
    @inlinable
    public init(_ indexPath: IndexPath) {
        self.init(externalRepresentation: indexPath,
                  internalRepresentation: indexPath.item)
    }
}
