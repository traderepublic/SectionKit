import Foundation

typealias NamesSectionViewModelType = NamesSectionViewModelInputs & NamesSectionViewModelOutputs

protocol NamesSectionViewModelInputs {
    func select(name: String)
    func pressCollapse()
}

protocol NamesSectionViewModelOutputs {
    var sectionId: String { get }
    var sectionTitle: String { get }
    var names: [String] { get }
    var isCollapsed: Bool { get }
}

protocol NamesSectionNavigation {
    func show(name: String)
}

final class NamesSectionViewModel: NamesSectionViewModelType {
    private let navigation: NamesSectionNavigation
    let sectionId: String
    let sectionTitle: String
    let names: [String]
    private(set) var isCollapsed = false

    init(
        sectionTitle: String,
        names: [String],
        navigation: NamesSectionNavigation
    ) {
        self.sectionId = sectionTitle
        self.sectionTitle = sectionTitle
        self.names = names
        self.navigation = navigation
    }

    func select(name: String) {
        navigation.show(name: name)
    }

    func pressCollapse() {
        isCollapsed.toggle()
    }
}
