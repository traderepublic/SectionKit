import Foundation
import UIKit.UIColor

internal typealias ColorsViewModelType = ColorsViewModelInputs & ColorsViewModelOutputs

internal protocol ColorsViewModelInputs {
    func select(color: UIColor)
}

internal protocol ColorsViewModelOutputs {
    var title: String { get }
    var colors: [UIColor] { get }
}

internal protocol ColorsNavigation {
    func show(color: UIColor)
}

internal struct ColorsViewModel: ColorsViewModelType {
    private let navigation: ColorsNavigation

    internal let title = "Colors"
    internal let colors: [UIColor]

    internal init(colors: [UIColor], navigation: ColorsNavigation) {
        self.colors = colors
        self.navigation = navigation
    }

    internal func select(color: UIColor) {
        navigation.show(color: color)
    }
}
