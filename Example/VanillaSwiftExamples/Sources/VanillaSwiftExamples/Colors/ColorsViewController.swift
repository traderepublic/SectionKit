import UIKit
import SectionKit

final class ColorsViewController: UIViewController {
    private let viewModel: ColorsViewModelType

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    init(viewModel: ColorsViewModelType) {
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
        collectionViewAdapter = SingleSectionCollectionViewAdapter(
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

extension ColorsViewController: SingleSectionCollectionViewAdapterDataSource {
    func section(for adapter: CollectionViewAdapter) -> Section? {
        let model = viewModel
        return Section(
            id: "colors",
            model: model,
            controller: ColorsSectionController(model: model)
        )
    }
}
