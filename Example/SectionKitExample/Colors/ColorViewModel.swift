import Foundation
import UIKit.UIColor

typealias ColorViewModelType = ColorViewModelInputs & ColorViewModelOutputs

protocol ColorViewModelInputs {
    func select(color: UIColor)
}

protocol ColorViewModelOutputs {
    var title: String { get }
    var colors: [UIColor] { get }
}

protocol ColorNavigation {
    func show(color: UIColor)
}

struct ColorViewModel: ColorViewModelType {
    private let navigation: ColorNavigation

    let title = "Colors"
    let colors: [UIColor]

    init(colors: [UIColor], navigation: ColorNavigation) {
        self.colors = colors
        self.navigation = navigation
    }

    func select(color: UIColor) {
        navigation.show(color: color)
    }
}
