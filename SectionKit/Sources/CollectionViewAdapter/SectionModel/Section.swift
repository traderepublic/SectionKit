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
     Initialize an instance of `Section`.

     - Parameter id: An identifier that uniquely identifies this section.

     - Parameter model: The model of the section.

     - Parameter controller: A handler that produces the `SectionController` for this section.
     */
    public init(
        id: AnyHashable,
        model: Any,
        controller: @autoclosure @escaping () -> SectionController
    ) {
        self.id = id
        self.model = model
        self.controllerAccessor = controller
    }
}
