import UIKit

protocol ProfilePictureSectionViewModelType: AnyObject {
    var output: ProfilePictureSectionViewModelOutput { get }
}

protocol ProfilePictureSectionViewModelOutput {
    var id: UUID { get }
    var profilePicture: UIImage { get }
}

class ProfilePictureSectionViewModel: ProfilePictureSectionViewModelType,
                                      ProfilePictureSectionViewModelOutput {
    var output: ProfilePictureSectionViewModelOutput { self }

    let id = UUID()
    let profilePicture: UIImage = UIImage(named: "logo")!
}

extension ProfilePictureSectionViewModel: Identifiable {
    
}

extension ProfilePictureSectionViewModel: Equatable {
    static func == (lhs: ProfilePictureSectionViewModel, rhs: ProfilePictureSectionViewModel) -> Bool {
        lhs.output.profilePicture == rhs.output.profilePicture
    }
}
