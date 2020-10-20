import DifferenceKit
import Foundation
import SectionKit

extension Section: Differentiable {
    @inlinable
    public var differenceIdentifier: AnyHashable { model.sectionId }

    @inlinable
    public func isContentEqual(to source: Section) -> Bool {
        // only check for section id since we do not want to reload the section in the collection view
        // changes to the section will instead be handled by the sectioncontroller
        model.sectionId == source.model.sectionId
    }
}
