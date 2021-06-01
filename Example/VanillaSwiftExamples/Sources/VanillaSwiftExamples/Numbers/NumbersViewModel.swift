import Foundation

internal typealias NumbersViewModelType = NumbersViewModelInputs & NumbersViewModelOutputs

internal protocol NumbersViewModelInputs { }

internal protocol NumbersViewModelOutputs {
    var title: String { get }
    var sections: [NumbersSectionViewModelType] { get }
}

internal struct NumbersViewModel: NumbersViewModelType {
    internal let title = "Numbers"
    internal let sections: [NumbersSectionViewModelType]

    internal init(navigation: NumbersSectionNavigation) {
        sections = [
            NumbersSectionViewModel(numbers: Array(0...1), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(10...19), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(20...24), navigation: navigation)
        ]
    }
}
