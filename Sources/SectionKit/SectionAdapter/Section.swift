import Foundation

public class Section {
    public let id: AnyHashable
    public let model: AnyHashable
    public let controller: SectionController
    
    public init(id: AnyHashable, model: AnyHashable, controller: SectionController) {
        self.id = id
        self.model = model
        self.controller = controller
    }
}
