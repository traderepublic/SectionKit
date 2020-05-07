import Foundation
import SectionKit
import DifferenceKit

extension Section: Differentiable {
    @inlinable
    public var differenceIdentifier: AnyHashable { id }
    
    @inlinable
    public func isContentEqual(to source: Section) -> Bool {
        model == source.model
    }
}
