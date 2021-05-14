import Foundation
import UIKit.UIColor

typealias ExampleViewModelType = ExampleViewModelInputs & ExampleViewModelOutputs

protocol ExampleViewModelInputs {
    func didSelect()
}

protocol ExampleViewModelOutputs {
    var name: String { get }
}

protocol ExampleNavigation {
    func show(example: ExampleViewModelType)
}

struct ExampleViewModel: ExampleViewModelType {
    private let navigation: ExampleNavigation

    let name: String

    init(name: String, navigation: ExampleNavigation) {
        self.name = name
        self.navigation = navigation
    }

    func didSelect() {
        navigation.show(example: self)
    }
}
