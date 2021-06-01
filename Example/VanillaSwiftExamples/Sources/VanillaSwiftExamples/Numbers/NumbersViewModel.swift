import Foundation

typealias NumbersViewModelType = NumbersViewModelInputs & NumbersViewModelOutputs

protocol NumbersViewModelInputs { }

protocol NumbersViewModelOutputs {
    var title: String { get }
    var sections: [NumbersSectionViewModelType] { get }
}

struct NumbersViewModel: NumbersViewModelType {
    let title = "Numbers"
    let sections: [NumbersSectionViewModelType]

    init(navigation: NumbersSectionNavigation) {
        sections = [
            NumbersSectionViewModel(numbers: Array(0...1), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(10...19), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(20...24), navigation: navigation)
        ]
    }
}
