import Foundation

protocol ProfileViewModelType: AnyObject {
    var input: ProfileViewModelInput { get }
    var output: ProfileViewModelOutput { get }
}

protocol ProfileViewModelInput {
    func add(member: String)
}

protocol ProfileViewModelOutput {
    var title: String { get }
    var profilePictureSection: ProfilePictureSectionViewModel { get }
    var personalInformationSection: PersonalInformationSectionViewModel { get }
    var teamMemberSection: TeamMemberSectionViewModel { get }
}

class ProfileViewModel: ProfileViewModelType,
                        ProfileViewModelInput,
                        ProfileViewModelOutput {
    var input: ProfileViewModelInput { self }
    var output: ProfileViewModelOutput { self }

    // MARK: - Input
    func add(member: String) {
        teamMemberSection.input.add(member: member)
    }

    // MARK: - Output
    let title = "Profile"
    let profilePictureSection = ProfilePictureSectionViewModel()
    let personalInformationSection = PersonalInformationSectionViewModel(firstName: "Niklas", lastName: "Hein")
    let teamMemberSection = TeamMemberSectionViewModel()
}
