import UIKit
import SectionKit

final class NumbersViewController: UIViewController {
    private let viewModel: NumbersViewModelType

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    init(viewModel: NumbersViewModelType) {
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

extension NumbersViewController: ListCollectionViewAdapterDataSource {
    func sections(for adapter: CollectionViewAdapter) -> [Section] {
        viewModel.sections.map {
            Section(
                id: $0.sectionId,
                model: $0,
                controller: NumbersSectionController(model: $0)
            )
        }
    }
}
