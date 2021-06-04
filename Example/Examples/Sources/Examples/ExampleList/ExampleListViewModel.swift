import Foundation

internal typealias ExampleListViewModelType = ExampleListViewModelInputs & ExampleListViewModelOutputs

internal protocol ExampleListViewModelInputs { }

internal protocol ExampleListViewModelOutputs {
    var title: String { get }
    var sections: [ExampleSectionViewModelType] { get }
}

internal struct ExampleListViewModel: ExampleListViewModelType {
    internal let title = "Examples"
    internal let sections: [ExampleSectionViewModelType]
}
