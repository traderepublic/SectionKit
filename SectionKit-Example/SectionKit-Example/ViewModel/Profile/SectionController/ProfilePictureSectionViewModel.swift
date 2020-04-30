import UIKit

protocol ProfilePictureSectionViewModelType: AnyObject {
    associatedtype Output

    var output: Output { get }
}

protocol ProfilePictureSectionViewModelOutput {
    var profilePicture: UIImage { get }
}

class ProfilePictureSectionViewModel: ProfilePictureSectionViewModelType,
                                      ProfilePictureSectionViewModelOutput {
    var output: ProfilePictureSectionViewModelOutput { self }

    let profilePicture: UIImage = UIImage(named: "logo")!
}
