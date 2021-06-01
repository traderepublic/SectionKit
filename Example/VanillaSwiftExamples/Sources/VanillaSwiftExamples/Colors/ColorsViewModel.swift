import Foundation
import UIKit.UIColor

typealias ColorsViewModelType = ColorsViewModelInputs & ColorsViewModelOutputs

protocol ColorsViewModelInputs {
    func select(color: UIColor)
}

protocol ColorsViewModelOutputs {
    var title: String { get }
    var colors: [UIColor] { get }
}

protocol ColorsNavigation {
    func show(color: UIColor)
}

struct ColorsViewModel: ColorsViewModelType {
    private let navigation: ColorsNavigation

    let title = "Colors"
    let colors: [UIColor]

    init(colors: [UIColor], navigation: ColorsNavigation) {
        self.colors = colors
        self.navigation = navigation
    }

    func select(color: UIColor) {
        navigation.show(color: color)
    }
}
