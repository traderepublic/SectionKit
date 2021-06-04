import Foundation

internal typealias NumbersSectionViewModelType = NumbersSectionViewModelInputs & NumbersSectionViewModelOutputs

internal protocol NumbersSectionViewModelInputs {
    func select(number: Int)
}

internal protocol NumbersSectionViewModelOutputs {
    var sectionId: UUID { get }
    var numbers: [Int] { get }
}

internal protocol NumbersSectionNavigation {
    func show(number: Int)
}

internal struct NumbersSectionViewModel: NumbersSectionViewModelType {
    private let navigation: NumbersSectionNavigation

    internal let sectionId: UUID
    internal let numbers: [Int]

    internal init(numbers: [Int], navigation: NumbersSectionNavigation, sectionId: UUID = UUID()) {
        self.sectionId = sectionId
        self.numbers = numbers
        self.navigation = navigation
    }

    internal func select(number: Int) {
        navigation.show(number: number)
    }
}
