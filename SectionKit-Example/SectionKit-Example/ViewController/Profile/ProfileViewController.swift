import DiffingSectionKit
import SectionKit
import UIKit

class ProfileViewController: UIViewController {
    // MARK: - Properties
    let viewModel: ProfileViewModel
    var sectionAdapter: SectionAdapter!

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGroupedBackground
        return collectionView
    }()

    private lazy var profilePictureSectionController: SectionController = {
        let sectionViewModel = viewModel.output.profilePictureSection
        let controller = SingleItemSectionController (id: "profilePicture")
        controller.cellProvider = { context, indexPath in
            let cell = context.dequeueReusableCell(ProfilePictureCell.self, for: indexPath.externalRepresentation)
            cell.configure(with: sectionViewModel)
            return cell
        }
        controller.sizeProvider = { context, _, _ -> CGSize in
            ProfilePictureCell.size(for: sectionViewModel, size: context.containerSize)
        }
        return controller
    }()
 
    private lazy var personalInformationSectionController: SectionController = {
        let sectionViewModel = viewModel.output.personalInformationSection

        let controller = ListSectionController<String>()
        controller.items = [sectionViewModel.firstName, sectionViewModel.lastName]
        controller.cellProvider = { context, item, indexPath in

            let cell = context.dequeueReusableCell(PlainTextCell.self, for: indexPath.externalRepresentation)
            cell.configure(with: item)
            return cell
        }
        controller.sizeProvider = { context, item, _, _ in
            PlainTextCell.size(for: item, size: context.containerSize)
        }
        return controller
    }()

    private lazy var teamMemberSectionController: SectionController = {
        let sectionViewModel = viewModel.output.teamMemberSection

        let controller = TeamMemberSectionController(viewModel: sectionViewModel)
        controller.cellProvider = { context, item, indexPath in
            let cell = context.dequeueReusableCell(PlainTextCell.self, for: indexPath.externalRepresentation)
            cell.configure(with: item)
            return cell
        }
        controller.sizeProvider = { context, item, _, _ in
            PlainTextCell.size(for: item, size: context.containerSize)
        }
        return controller
    }()

    // MARK: - Initialization
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.output.title
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)

        sectionAdapter = SectionAdapter(viewController: self,
                                        collectionView: collectionView,
                                        sectionControllers: [profilePictureSectionController,
                                                             personalInformationSectionController,
                                                             teamMemberSectionController])
        setUpConstraints()
    }
}

extension ProfileViewController {
    private func setUpConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ])
    }
}
