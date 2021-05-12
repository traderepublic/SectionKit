import UIKit
import SectionKit

final class ColorViewController: UIViewController {
    private let viewModel: ColorViewModelType

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    init(viewModel: ColorViewModelType) {
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

extension ColorViewController: SingleSectionCollectionViewAdapterDataSource {
    func section(for adapter: CollectionViewAdapter) -> Section? {
        let model = viewModel
        return Section(
            id: "colors",
            model: model,
            controller: ColorSectionController(model: model)
        )
    }
}
