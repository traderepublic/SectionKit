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

    private lazy var addMemberButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Add Member", for: .normal)
        let titleFont = UIFont.preferredFont(forTextStyle: .title3)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: titleFont.pointSize)
        button.addTarget(self, action: #selector(didTapAddMember), for: .touchUpInside)
        return button
    }()

    private lazy var addMemberStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addMemberButton])
        stackView.alignment = .top
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private lazy var addMemberContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.addSubview(addMemberStackView)
        return view
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
        controller.didSelect = { _, member, _ in
            sectionViewModel.input.remove(member: member)
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
        view.addSubview(addMemberContentView)

        sectionAdapter = SectionAdapter(viewController: self,
                                        collectionView: collectionView,
                                        sectionControllers: [profilePictureSectionController,
                                                             personalInformationSectionController,
                                                             teamMemberSectionController])
        setUpConstraints()
    }

    // MARK: - User Input
    @objc private func didTapAddMember() {
        let alertController = UIAlertController(title: "Add member", message: nil, preferredStyle: .alert)

        alertController.addTextField(configurationHandler: nil)

        let addMemberAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let name = alertController.textFields?.first?.text else {
                return
            }

            self.viewModel.input.add(member: name)
        }

        alertController.addAction(addMemberAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
}

extension ProfileViewController {
    private func setUpConstraints() {
        [collectionView, addMemberContentView, addMemberStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            // CollectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
            // AddMemberStackView
            addMemberStackView.leadingAnchor.constraint(equalTo: addMemberContentView.leadingAnchor),
            addMemberContentView.trailingAnchor.constraint(equalTo: addMemberStackView.trailingAnchor),
            addMemberStackView.topAnchor.constraint(equalTo: addMemberContentView.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: addMemberStackView.bottomAnchor),
            // AddMemberContentView
            addMemberContentView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            addMemberContentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: addMemberContentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: addMemberContentView.bottomAnchor),
        ])
    }
}
