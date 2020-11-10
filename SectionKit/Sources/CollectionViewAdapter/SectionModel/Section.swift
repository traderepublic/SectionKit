import Foundation

/// Represents a section in the `UICollectionView`.
public class Section {
    /// An identifier that uniquely identifies this section.
    public let id: AnyHashable

    /// The model of the section.
    public let model: Any

    /// A closure to determine if two model instances are equal.
    public let isModelEqual: (Any, Any) -> Bool

    private let controllerAccessor: () -> SectionController?

    /// A `SectionController` for this section.
    public internal(set) lazy var controller: SectionController? = controllerAccessor()

    /**
     Initialize an instance of `Section`.

     - Parameter id: An identifier that uniquely identifies this section.

     - Parameter model: The model of the section.

     - Parameter isModelEqual: A closure to determine if two model instances are equal.

     - Parameter controller: A handler that produces the `SectionController` for this section.
     */
    public init<Model>(id: AnyHashable,
                       model: Model,
                       isModelEqual: @escaping (Model, Model) -> Bool,
                       controller: @autoclosure @escaping () -> SectionController?) {
        self.id = id
        self.model = model
        self.isModelEqual = { lhs, rhs in
            guard let lhs = lhs as? Model, let rhs = rhs as? Model else { return false }
            return isModelEqual(lhs, rhs)
        }
        self.controllerAccessor = controller
    }

    /**
     Initialize an instance of `Section`.

     - Parameter id: An identifier that uniquely identifies this section.

     - Parameter model: The model of the section.

     - Parameter controller: A handler that produces the `SectionController` for this section.
     */
    public init<Model: Equatable>(id: AnyHashable,
                                  model: Model,
                                  controller: @autoclosure @escaping () -> SectionController?) {
        self.id = id
        self.model = model
        self.isModelEqual = { lhs, rhs in
            guard let lhs = lhs as? Model, let rhs = rhs as? Model else { return false }
            return lhs == rhs
        }
        self.controllerAccessor = controller
    }
}
