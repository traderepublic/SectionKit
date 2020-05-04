import SectionKit
import UIKit

class TeamMemberSectionController: FoundationDiffingListSectionController<String> {

    // MARK: - Properties
    private let viewModel: TeamMemberSectionViewModel

    init(viewModel: TeamMemberSectionViewModel) {
        self.viewModel = viewModel
        super.init(id: UUID().uuidString)
        items = viewModel.output.members
        viewModel.delegate = self
    }

    // MARK: - Datasource
    override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        let headerView = context!.dequeueReusableHeaderView(PlainTextHeader.self, for: indexPath.externalRepresentation)
        headerView.configure(with: viewModel.output.headerTitle)
        return headerView
    }

    override func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        PlainTextCell.size(for: viewModel.output.headerTitle, size: context!.containerSize)
    }
}

extension TeamMemberSectionController: TeamMemberSectionViewModelDelegate {
    func didUpdate(members: [String]) {
        items = members
    }
}
