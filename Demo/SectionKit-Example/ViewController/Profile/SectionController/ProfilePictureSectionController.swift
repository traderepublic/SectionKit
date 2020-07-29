import UIKit
import SectionKit

extension ProfilePictureSectionViewModel: SectionIdentifiable, SectionEquatable { }

class ProfilePictureSectionController:
    SingleItemSectionController<ProfilePictureSectionViewModel, UIImage>
{
    override func item(for model: ProfilePictureSectionViewModel) -> UIImage? {
        return model.output.profilePicture
    }
    
    override func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        let cell = context!.dequeueReusableCell(ProfilePictureCell.self,
                                                for: indexPath.externalRepresentation)
        cell.configure(with: item!)
        return cell
    }
    
    override func sizeForItem(at indexPath: SectionIndexPath,
                       using layout: UICollectionViewLayout) -> CGSize {
        return ProfilePictureCell.size(for: item!,
                                       size: context!.containerSize)
    }
    
    override func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    override func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
}
