import Foundation
import SectionKit
import DifferenceKit

extension Section: Differentiable {
    @inlinable
    public var differenceIdentifier: AnyHashable { model.sectionId }
    
    @inlinable
    public func isContentEqual(to source: Section) -> Bool {
        model.isEqual(to: source.model) 
    }
}
