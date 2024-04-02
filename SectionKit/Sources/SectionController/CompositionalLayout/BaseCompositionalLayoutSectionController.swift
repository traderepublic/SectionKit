import UIKit

/// This is a foundational implementation of `CompositionalLayoutSectionController`, adding the compositional layout section delegate function while inheriting from the `BaseSectionController`.
@MainActor
@available(iOS 13.0, *)
open class BaseCompositionalLayoutSectionController: BaseSectionController,
                                                     CompositionalLayoutSectionController {
    open func layoutSection(
        layoutEnvironment: any NSCollectionLayoutEnvironment
    ) -> NSCollectionLayoutSection {
        context?.errorHandler.nonCritical(error: .notImplemented())
        return .empty
    }
}
