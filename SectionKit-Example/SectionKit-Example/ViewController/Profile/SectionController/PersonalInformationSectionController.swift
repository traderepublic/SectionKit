import UIKit
import SectionKit

extension PersonalInformationSectionViewModel: SectionIdentifiable, SectionEquatable { }

class PersonalInformationSectionController:
    ListSectionController<PersonalInformationSectionViewModel, String>
{
    override func items(for model: PersonalInformationSectionViewModel) -> [String] {
        return [
            model.firstName,
            model.lastName
        ]
    }
    
    override func cell(for item: String,
                       at indexPath: SectionIndexPath) -> UICollectionViewCell {
        let cell = context!.dequeueReusableCell(PlainTextCell.self,
                                                for: indexPath.externalRepresentation)
        cell.configure(with: item)
        return cell
    }
    
    override func size(for item: String,
                       at indexPath: SectionIndexPath,
                       using layout: UICollectionViewLayout) -> CGSize {
        return PlainTextCell.size(for: item, size: context!.containerSize)
    }
}
