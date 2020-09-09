import Foundation

/// Defines a function to check for equality between two sections.
public protocol SectionEquatable {
    /// Determines if `self` and the given section are equal.
    func isEqual(to section: SectionEquatable) -> Bool
}

extension SectionEquatable where Self: Equatable {
    @inlinable
    public func isEqual(to section: SectionEquatable) -> Bool {
        guard let section = section as? Self else { return false }
        return self == section
    }
}
