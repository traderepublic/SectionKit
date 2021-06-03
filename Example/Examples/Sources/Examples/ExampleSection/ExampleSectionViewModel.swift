import Foundation

internal typealias ExampleSectionViewModelType = ExampleSectionViewModelInputs & ExampleSectionViewModelOutputs

internal protocol ExampleSectionViewModelInputs { }

internal protocol ExampleSectionViewModelOutputs {
    var sectionId: ExampleSectionId { get }
    var header: String { get }
    var footer: String? { get }
    var examples: [ExampleViewModelType] { get }
}

internal struct ExampleSectionViewModel: ExampleSectionViewModelType {
    internal let sectionId: ExampleSectionId
    internal let header: String
    internal let footer: String?
    internal let examples: [ExampleViewModelType]
}
