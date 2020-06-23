import Foundation

public protocol SectionEquatable {
    func isEqual(to section: SectionEquatable) -> Bool
}

public extension SectionEquatable where Self: Equatable {
    @inlinable
    func isEqual(to section: SectionEquatable) -> Bool {
        guard let section = section as? Self else { return false }
        return self == section
    }
}
