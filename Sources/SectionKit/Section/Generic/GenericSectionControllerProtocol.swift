import Foundation

/// A `SectionController` that handles a list of items.
public protocol GenericSectionControllerProtocol: SectionController {
    associatedtype Item
    
    /// The items that should be displayed in this section.
    var items: [Item] { get set }
    
    /**
     Calculate the `UICollectionView` events using the difference from the old to the new data
     
     - Parameter oldData: The old data currently displayed in the section
     
     - Parameter newData: The new data that should be displayed in the section
     
     - Returns: The update that should be performed on the section
     */
    func calculateUpdate(from oldData: [Item], to newData: [Item]) -> SectionUpdate<[Item]>
}

