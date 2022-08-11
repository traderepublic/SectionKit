import Foundation

internal typealias NumbersViewModelType = NumbersViewModelInputs & NumbersViewModelOutputs

internal protocol NumbersViewModelInputs {
    mutating func collapsePressed()
}

internal protocol NumbersViewModelOutputs {
    var title: String { get }
    var sections: [NumbersSectionViewModelType] { get }
    var collapseButtonTitle: String { get }
}

internal struct NumbersViewModel: NumbersViewModelType {
    internal let title = "Numbers"
    private let allSections: [NumbersSectionViewModelType]
    private var isCollapsed = false
    internal var sections: [NumbersSectionViewModelType] {
        isCollapsed ? allSections.dropLast() : allSections
    }
    internal var collapseButtonTitle: String {
        isCollapsed ? "Uncollapse" : "Collapse"
    }

    internal init(navigation: NumbersSectionNavigation) {
        allSections = [
            NumbersSectionViewModel(numbers: Array(0...1), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(10...19), navigation: navigation),
            NumbersSectionViewModel(numbers: Array(20...24), navigation: navigation)
        ]
    }

    internal mutating func collapsePressed() {
        isCollapsed.toggle()
    }
}
