import Foundation

public class Section {
    public let model: SectionModel
    public let controller: SectionController
    
    public init(model: SectionModel, controller: SectionController) {
        self.model = model
        self.controller = controller
    }
}
