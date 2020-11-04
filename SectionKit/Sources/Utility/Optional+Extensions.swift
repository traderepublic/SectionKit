import Foundation

extension Optional {
    /// A Boolean value indicating whether the optional holds an actual value.
    @inlinable
    internal var isSome: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }

    /// A Boolean value indicating whether the optional is `nil`.
    @inlinable
    internal var isNone: Bool { !isSome }
}
