import Foundation

protocol PersonalInformationSectionViewModelType: AnyObject {
    var output: PersonalInformationSectionViewModelOutput { get }
}

protocol PersonalInformationSectionViewModelOutput {
    var firstName: String { get }
    var lastName: String { get }
}

class PersonalInformationSectionViewModel: PersonalInformationSectionViewModelType,
                                           PersonalInformationSectionViewModelOutput {
    var output: PersonalInformationSectionViewModelOutput { self }

    let firstName: String
    let lastName: String

    init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}
