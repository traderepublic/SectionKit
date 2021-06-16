import Foundation

extension Array {
    /**
     Accesses the element at the specified index path.

     - Parameter sectionIndexPath: The index path of the element to access.
     */
    @inlinable
    public subscript(sectionIndexPath: SectionIndexPath) -> Element {
        get { self[sectionIndexPath.indexInSectionController] }
        set { self[sectionIndexPath.indexInSectionController] = newValue }
    }
}
