import Foundation

extension Collection {
    /// A Boolean value indicating whether the collection is not empty.
    @usableFromInline
    internal var isNotEmpty: Bool { !isEmpty }
}
