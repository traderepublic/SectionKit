import DifferenceKit
import Foundation

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension ContentIdentifiable where Self: Identifiable {
    @inlinable
    public var differenceIdentifier: ID { id }
}
