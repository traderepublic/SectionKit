import Foundation

/// A struct containing the internal and external index of an item.
public struct SectionIndexPath: Equatable {
    /// The index path of the item in the `UICollectionView`.
    public let indexInCollectionView: IndexPath

    /// The index of the item in the current `SectionController`.
    public let indexInSectionController: Int

    /**
     Initialize an instance of `SectionIndexPath`.

     - Parameter indexInCollectionView: The index path of the item in the `UICollectionView`.

     - Parameter indexInSectionController: The index of the item in the current `SectionController`.
     */
    public init(indexInCollectionView: IndexPath, indexInSectionController: Int) {
        self.indexInCollectionView = indexInCollectionView
        self.indexInSectionController = indexInSectionController
    }

    /**
     Initialize an instance of `SectionIndexPath`.

     - Parameter indexInCollectionView: The index path of the item in the `UICollectionView`.

     - Parameter indexInSectionController: The index of the item in the current `SectionController`.
     */
    public init(_ indexPath: IndexPath) {
        self.indexInCollectionView = indexPath
        self.indexInSectionController = indexPath.item
    }
}
