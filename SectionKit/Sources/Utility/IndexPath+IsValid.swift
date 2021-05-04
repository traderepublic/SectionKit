import Foundation

extension IndexPath {
    @usableFromInline
    internal var isValid: Bool {
        count == 2 // precondition of the `section` property
    }
}
