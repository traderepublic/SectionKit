import Foundation

public struct SectionIndexPath {
    /// The index path of an item in the `UICollectionView`
    public let externalRepresentation: IndexPath
    
    /// The internal index of the item
    public let internalRepresentation: Int
    
    public init(externalRepresentation: IndexPath, internalRepresentation: Int) {
        self.externalRepresentation = externalRepresentation
        self.internalRepresentation = internalRepresentation
    }
    
    public init(_ indexPath: IndexPath) {
        externalRepresentation = indexPath
        internalRepresentation = indexPath.item
    }
}


