import Foundation
import UIKit.UIColor

internal typealias ExampleViewModelType = ExampleViewModelInputs & ExampleViewModelOutputs

internal protocol ExampleViewModelInputs {
    func didSelect()
}

internal protocol ExampleViewModelOutputs {
    var name: String { get }
}

internal protocol ExampleNavigation {
    func showDetail()
}

internal struct ExampleViewModel: ExampleViewModelType {
    private let navigation: ExampleNavigation

    internal let name: String

    internal init(name: String, navigation: ExampleNavigation) {
        self.name = name
        self.navigation = navigation
    }

    internal func didSelect() {
        navigation.showDetail()
    }
}
