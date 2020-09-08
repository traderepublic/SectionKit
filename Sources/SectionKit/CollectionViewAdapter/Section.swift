import Foundation

/// Represents a section in the `UICollectionView`.
public class Section {
    /// The model of the section.
    public let model: SectionModel

    private let controllerAccessor: () -> SectionController

    /// A lazily computed `SectionController` for this section.
    public private(set) lazy var controller: SectionController = controllerAccessor()

    /**
     Initialize an instance of `CollectionViewUpdate`.

     - Parameter model: The model of the section.

     - Parameter controllerAccessor: A handler that produces the `SectionController` for this section.
     */
    public init(model: SectionModel,
                controllerAccessor: @escaping () -> SectionController) {
        self.model = model
        self.controllerAccessor = controllerAccessor
    }
}

extension Section {
    /**
     Initialize an instance of `CollectionViewUpdate`.

     - Parameter model: The model of the section.

     - Parameter controller: The `SectionController` for this section.
     */
    @inlinable
    public convenience init(model: SectionModel, controller: SectionController) {
        self.init(model: model, controllerAccessor: { controller })
    }
}
