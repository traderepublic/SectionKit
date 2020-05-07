import Foundation
import SectionKit
import DifferenceKit

extension Section: Differentiable {
    public var differenceIdentifier: AnyHashable { id }
    
    public func isContentEqual(to source: Section) -> Bool {
        model == source.model
    }
}
