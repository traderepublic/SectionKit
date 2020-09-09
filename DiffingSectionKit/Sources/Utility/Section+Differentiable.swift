import DifferenceKit
import Foundation
import SectionKit

extension Section: Differentiable {
    @inlinable
    public var differenceIdentifier: AnyHashable { model.sectionId }

    @inlinable
    public func isContentEqual(to source: Section) -> Bool {
        model.sectionId == source.model.sectionId
    }
}
