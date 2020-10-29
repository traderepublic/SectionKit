import Foundation

extension IndexPath {
    @inlinable
    internal var isValid: Bool {
        count == 2 // precondition of the `section` property
    }
}
