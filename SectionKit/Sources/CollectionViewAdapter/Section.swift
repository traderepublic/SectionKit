import Foundation

/// Represents a section in the `UICollectionView`.
public class Section {
    /// An identifier that uniquely identifies this section.
    public let id: AnyHashable

    /// The model of the section.
    public let model: Any

    private let controllerAccessor: () -> SectionController

    /// A `SectionController` for this section.
    public internal(set) lazy var controller: SectionController = controllerAccessor()

    /**
     Initialise an instance of `Section`.

     - Parameter id: An identifier that uniquely identifies this section.

     - Parameter model: The model of the section.

     - Parameter controller: A closure that produces the `SectionController` for this section.
     */
    public init(
        id: AnyHashable,
        model: Any,
        controller: @escaping () -> SectionController
    ) {
        self.id = id
        self.model = model
        self.controllerAccessor = controller
    }
}

extension Section {
    /**
     Initialise an instance of `Section`.

     - Parameter id: An identifier that uniquely identifies this section.

     - Parameter model: The model of the section.

     - Parameter controller: An autoclosure that produces the `SectionController` for this section.
     */
    public convenience init(
        id: AnyHashable,
        model: Any,
        controller: @autoclosure @escaping () -> SectionController
    ) {
        self.init(id: id, model: model, controller: controller)
    }
}
