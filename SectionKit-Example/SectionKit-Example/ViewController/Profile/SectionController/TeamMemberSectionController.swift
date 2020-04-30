import SectionKit
import UIKit

class TeamMemberSectionController: FoundationDiffingListSectionController<String> {
    // MARK: - Properties
    private let viewModel: TeamMemberSectionViewModel

    init(viewModel: TeamMemberSectionViewModel) {
        self.viewModel = viewModel
        super.init(id: UUID().uuidString)
        items = viewModel.output.members
    }

    // MARK: - Datasource
    override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
        let headerView = context!.dequeueReusableHeaderView(PlainTextCell.self, for: indexPath.externalRepresentation)
        headerView.configure(with: viewModel.output.headerTitle)
        headerView.titleLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        headerView.backgroundColor = nil
        return headerView
    }

    override func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
        PlainTextCell.size(for: viewModel.output.headerTitle, size: context!.containerSize)
    }
}
