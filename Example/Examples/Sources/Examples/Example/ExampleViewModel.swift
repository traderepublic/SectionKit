import Foundation

internal typealias ExampleViewModelType = ExampleViewModelInputs & ExampleViewModelOutputs

internal protocol ExampleViewModelInputs {
    func didSelect()
}

internal protocol ExampleViewModelOutputs {
    var name: String { get }
    var description: String? { get }
}

internal protocol ExampleNavigation {
    func showDetail()
}

internal struct ExampleViewModel: ExampleViewModelType {
    private let navigation: ExampleNavigation

    internal let name: String
    internal let description: String?

    internal init(name: String, description: String?, navigation: ExampleNavigation) {
        self.name = name
        self.description = description
        self.navigation = navigation
    }

    internal func didSelect() {
        navigation.showDetail()
    }
}
