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
    
    override func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        let cell = context!.dequeueReusableCell(PlainTextCell.self,
                                                for: indexPath.externalRepresentation)
        cell.configure(with: items[indexPath.internalRepresentation])
        return cell
    }
    
    override func sizeForItem(at indexPath: SectionIndexPath,
                              using layout: UICollectionViewLayout) -> CGSize {
        return PlainTextCell.size(for: items[indexPath.internalRepresentation],
                                  size: context!.containerSize)
    }
    
    override func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    override func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
}
