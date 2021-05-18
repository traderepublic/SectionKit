import Foundation

typealias ExampleListViewModelType = ExampleListViewModelInputs & ExampleListViewModelOutputs

protocol ExampleListViewModelInputs { }

protocol ExampleListViewModelOutputs {
    var title: String { get }
    var sections: [ExampleSectionViewModelType] { get }
}

struct ExampleListViewModel: ExampleListViewModelType {
    let title = "Examples"
    let sections: [ExampleSectionViewModelType]
}
