import Foundation

protocol TeamMemberSectionViewModelType: AnyObject {
    var input: TeamMemberSectionViewModelInput { get }
    var output: TeamMemberSectionViewModelOutput { get }
}

protocol TeamMemberSectionViewModelInput {
    func add(member: String)
    func remove(member: String)
}

protocol TeamMemberSectionViewModelOutput {
    var members: [String] { get }
    var headerTitle: String { get }
}

class TeamMemberSectionViewModel: TeamMemberSectionViewModelType,
                                  TeamMemberSectionViewModelInput,
                                  TeamMemberSectionViewModelOutput {
    var input: TeamMemberSectionViewModelInput { self }
    var output: TeamMemberSectionViewModelOutput { self }

    private var mutableMembers: [String] = []

    // MARK: - Input
    func add(member: String) {
        mutableMembers.append(member)
    }

    func remove(member: String) {
        mutableMembers.removeAll { $0 == member }
    }

    // MARK: - Output
    var members: [String] { mutableMembers }
    let headerTitle: String = "Team Members"

    init() {
        mutableMembers = ["Marco", "Niclas", "Tom", "Flo", "Deniz"]
    }
}
