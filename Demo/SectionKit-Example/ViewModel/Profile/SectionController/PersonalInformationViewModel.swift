import Foundation

protocol PersonalInformationSectionViewModelType: AnyObject {
    var output: PersonalInformationSectionViewModelOutput { get }
}

protocol PersonalInformationSectionViewModelOutput {
    var id: UUID { get }
    var firstName: String { get }
    var lastName: String { get }
}

class PersonalInformationSectionViewModel: PersonalInformationSectionViewModelType,
                                           PersonalInformationSectionViewModelOutput {
    var output: PersonalInformationSectionViewModelOutput { self }

    // MARK: - Output
    let id = UUID()
    let firstName: String
    let lastName: String

    // MARK: - Initialization
    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension PersonalInformationSectionViewModel: Identifiable {
    
}

extension PersonalInformationSectionViewModel: Equatable {
    static func == (lhs: PersonalInformationSectionViewModel, rhs: PersonalInformationSectionViewModel) -> Bool {
        return lhs.output.firstName == rhs.output.firstName
            && lhs.output.lastName == rhs.output.lastName
    }
}
