import DifferenceKit
import Foundation

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
public extension ContentIdentifiable where Self: Identifiable {
    @inlinable
    var differenceIdentifier: ID {
        return id
    }
}
