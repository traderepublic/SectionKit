import UIKit
import SectionKit

internal final class NumbersViewController: UIViewController {
    private var viewModel: NumbersViewModelType {
        didSet {
            // `collapsePressed` mutates the viewmodel and thus invokes this `didSet` observer.
            // If the viewmodel is a class, the invalidation of the datasource needs to be performed with another solution, e.g. weak delegate.
            navigationItem.rightBarButtonItem?.title = viewModel.collapseButtonTitle
            collectionViewAdapter.invalidateDataSource()
        }
    }

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .zero
        layout.minimumLineSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    internal init(viewModel: NumbersViewModelType) {
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: viewModel.collapseButtonTitle,
            style: .plain,
            target: self,
            action: #selector(collapsePressed)
        )
        collectionViewAdapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: self
        )
    }

    @objc
    private func collapsePressed() {
        viewModel.collapsePressed()
    }
}

extension NumbersViewController: ListCollectionViewAdapterDataSource {
    internal func sections(for adapter: CollectionViewAdapter) -> [Section] {
        viewModel.sections.map {
            Section(
                id: $0.sectionId,
                model: $0,
                controller: NumbersSectionController(model: $0)
            )
        }
    }
}
