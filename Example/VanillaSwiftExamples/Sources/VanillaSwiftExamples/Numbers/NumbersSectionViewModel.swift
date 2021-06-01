import Foundation

typealias NumbersSectionViewModelType = NumbersSectionViewModelInputs & NumbersSectionViewModelOutputs

protocol NumbersSectionViewModelInputs {
    func select(number: Int)
}

protocol NumbersSectionViewModelOutputs {
    var sectionId: UUID { get }
    var numbers: [Int] { get }
}

protocol NumbersSectionNavigation {
    func show(number: Int)
}

struct NumbersSectionViewModel: NumbersSectionViewModelType {
    private let navigation: NumbersSectionNavigation

    let sectionId: UUID
    let numbers: [Int]

    init(numbers: [Int], navigation: NumbersSectionNavigation, sectionId: UUID = UUID()) {
        self.sectionId = sectionId
        self.numbers = numbers
        self.navigation = navigation
    }

    func select(number: Int) {
        navigation.show(number: number)
    }
}
