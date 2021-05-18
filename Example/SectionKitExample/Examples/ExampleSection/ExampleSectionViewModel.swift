import Foundation

typealias ExampleSectionViewModelType = ExampleSectionViewModelInputs & ExampleSectionViewModelOutputs

protocol ExampleSectionViewModelInputs { }

protocol ExampleSectionViewModelOutputs {
    var sectionId: ExampleSectionId { get }
    var header: String { get }
    var footer: String? { get }
    var examples: [ExampleViewModelType] { get }
}

struct ExampleSectionViewModel: ExampleSectionViewModelType {
    let sectionId: ExampleSectionId
    let header: String
    let footer: String?
    let examples: [ExampleViewModelType]
}
