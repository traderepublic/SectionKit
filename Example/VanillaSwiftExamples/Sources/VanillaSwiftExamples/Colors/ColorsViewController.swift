import UIKit
import SectionKit

internal final class ColorsViewController: UIViewController {
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

    internal init(viewModel: ColorsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override internal func loadView() {
        view = collectionView
    }

    override internal func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        collectionViewAdapter = SingleSectionCollectionViewAdapter(
            viewController: self,
            collectionView: collectionView,
            dataSource: self
        )
    }

    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectItems(in: collectionView, animated: animated)
    }
}

extension ColorsViewController: SingleSectionCollectionViewAdapterDataSource {
    internal func section(for adapter: CollectionViewAdapter) -> Section? {
        let model = viewModel
        return Section(
            id: "colors",
            model: model,
            controller: ColorsSectionController(model: model)
        )
    }
}
