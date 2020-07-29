import SectionKit
import UIKit

extension TeamMemberSectionViewModel: SectionIdentifiable, SectionEquatable { }

class TeamMemberSectionController:
    FoundationDiffingListSectionController<TeamMemberSectionViewModel, String>
{
    override init(model: TeamMemberSectionViewModel) {
        super.init(model: model)
        model.delegate = self
    }
    
    override func items(for model: TeamMemberSectionViewModel) -> [String] {
        return model.output.members
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
    
    override func didSelectItem(at indexPath: SectionIndexPath) {
        model.input.remove(member: items[indexPath.internalRepresentation])
    }
    
    // MARK: - Header
    
    override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        let headerView = context!.dequeueReusableHeaderView(PlainTextHeader.self, for: indexPath.externalRepresentation)
        headerView.configure(with: model.output.headerTitle)
        return headerView
    }

    override func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        PlainTextCell.size(for: model.output.headerTitle, size: context!.containerSize)
    }
}

extension TeamMemberSectionController: TeamMemberSectionViewModelDelegate {
    func didUpdate(members: [String]) {
        didUpdate(model: model)
    }
}
