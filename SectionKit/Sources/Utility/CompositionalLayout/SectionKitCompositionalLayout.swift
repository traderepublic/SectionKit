import UIKit

/// This compositional layout is designed for the section kit.
/// It ensures that the layout provider utilizes the layout section provided by the compositional layout section controller.
@MainActor
@available(iOS 13.0, *)
final public class SectionKitCompositionalLayout: UICollectionViewCompositionalLayout {
    // Use internally to bridge the sections from the adapter to the section provider.
    var sections: (() -> [Section])?

    public init() {
        var sections: (() -> [Section])?
        super.init { index, environment in
            guard let sections = sections?() else {
                assertionFailure("The section provider doesn't set up correctly, please use the `CollectionViewCompositionalLayoutAdapter`")
                return .empty
            }
            guard sections.count > index else {
                assertionFailure("Section index out of bound")
                return .empty
            }
            guard let compositionalLayoutSectionController = sections[index].controller
                    as? BaseCompositionalLayoutSectionController else {
                assertionFailure("Please use the `CompositionalLayoutSectionControler`")
                return .empty
            }
            return compositionalLayoutSectionController.layoutSection(
                layoutEnvironment: environment
            )
        }
        sections = { [weak self] in
            self?.sections?() ?? []
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @available(*, unavailable)
    override init(
        sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider,
        configuration: UICollectionViewCompositionalLayoutConfiguration
    ) {
        fatalError("init(sectionProvider:configuration:) has not been implemented")
    }

    @available(*, unavailable)
    override init(sectionProvider: @escaping UICollectionViewCompositionalLayoutSectionProvider) {
        fatalError("init(sectionProvider:) has not been implemented")
    }
}
