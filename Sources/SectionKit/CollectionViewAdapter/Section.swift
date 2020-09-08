import Foundation

public class Section {
    public let model: SectionModel

    private let controllerAccessor: () -> SectionController

    public lazy var controller: SectionController = controllerAccessor()

    public init(model: SectionModel,
                controllerAccessor: @escaping () -> SectionController) {
        self.model = model
        self.controllerAccessor = controllerAccessor
    }
}

public extension Section {
    @inlinable
    convenience init(model: SectionModel, controller: SectionController) {
        self.init(model: model, controllerAccessor: { controller })
    }
}
