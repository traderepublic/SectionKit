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
    var id: UUID { get }
    var members: [String] { get }
    var headerTitle: String { get }
    var delegate: TeamMemberSectionViewModelDelegate? { get }
}

class TeamMemberSectionViewModel:
    TeamMemberSectionViewModelType,
    TeamMemberSectionViewModelInput,
    TeamMemberSectionViewModelOutput
{
    var input: TeamMemberSectionViewModelInput { self }
    var output: TeamMemberSectionViewModelOutput { self }

    private var mutableMembers: [String] = []

    // MARK: - Input
    func add(member: String) {
        mutableMembers.append(member)
        delegate?.didUpdate(members: members)
    }

    func remove(member: String) {
        mutableMembers.removeAll { $0 == member }
        delegate?.didUpdate(members: members)

    }

    // MARK: - Output
    let id = UUID()
    var members: [String] { mutableMembers }
    let headerTitle: String = "Team Members"
    weak var delegate: TeamMemberSectionViewModelDelegate?

    // MARK: - Initialization
    init() {
        mutableMembers = ["Marco", "Niclas", "Tom", "Flo", "Deniz"]
    }
}

protocol TeamMemberSectionViewModelDelegate: AnyObject {
    func didUpdate(members: [String])
}

extension TeamMemberSectionViewModel: Identifiable {
    
}

extension TeamMemberSectionViewModel: Equatable {
    static func == (lhs: TeamMemberSectionViewModel, rhs: TeamMemberSectionViewModel) -> Bool {
        return lhs.output.headerTitle == rhs.output.headerTitle
            && lhs.output.members == rhs.output.members
    }
}
