import UIKit
import SectionKit

final class ExampleListViewController: UIViewController {
    private let viewModel: ExampleListViewModelType

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    init(viewModel: ExampleListViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        collectionViewAdapter = ListCollectionViewAdapter(
            viewController: self,
            collectionView: collectionView,
            dataSource: self
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectItems(in: collectionView, animated: animated)
    }
}

extension ExampleListViewController: ListCollectionViewAdapterDataSource {
    func sections(for adapter: CollectionViewAdapter) -> [Section] {
        viewModel.sections.map { model in
            Section(
                id: model.sectionId,
                model: model,
                controller: ExampleListSectionController(model: model)
            )
        }
    }
}
