import Foundation

typealias NamesViewModelType = NamesViewModelInputs & NamesViewModelOutputs

protocol NamesViewModelInputs { }

internal protocol NamesViewModelOutputs {
    var title: String { get }
    var sections: [NamesSectionViewModelType] { get }
}

struct NamesViewModel: NamesViewModelType {
    let title = "Names"
    let sections: [NamesSectionViewModelType]

    init(navigation: NamesSectionNavigation) {
        let namesDictionary: [String: [String]]

        if let url = Bundle.main.url(
            forResource: "first-names",
            withExtension: "json"
        ) {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let firstnames = try decoder.decode([String].self, from: data)
                namesDictionary = Dictionary.init(grouping: firstnames, by: { firstname in
                    firstname.first.map { String($0) } ?? ""
                })
            } catch {
                print("error:\(error)")
                namesDictionary = [:]
            }
        } else {
            namesDictionary = [:]
        }
        self.sections = namesDictionary.keys
            .sorted()
            .compactMap { key -> NamesSectionViewModel? in
                guard let names = namesDictionary[key] else { return nil }
                return NamesSectionViewModel(
                    sectionTitle: key,
                    names: names,
                    navigation: navigation
                )
            }
    }
}
