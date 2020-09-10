import Foundation

/// Defines a hashable id for a section.
public protocol SectionIdentifiable {
    /// An identifier that uniquely identifies a section.
    var sectionId: AnyHashable { get }
}

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension SectionIdentifiable where Self: Identifiable {
    @inlinable
    public var sectionId: AnyHashable { id }
}
