import Foundation

typealias ExampleListSectionViewModelType = ExampleListSectionViewModelInputs & ExampleListSectionViewModelOutputs

protocol ExampleListSectionViewModelInputs { }

protocol ExampleListSectionViewModelOutputs {
    var sectionId: ExampleListSectionId { get }
    var header: String { get }
    var footer: String? { get }
    var examples: [ExampleViewModelType] { get }
}

struct ExampleListSectionViewModel: ExampleListSectionViewModelType {
    let sectionId: ExampleListSectionId
    let header: String
    let footer: String?
    let examples: [ExampleViewModelType]
}
