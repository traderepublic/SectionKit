import UIKit
import SectionKit

final class NamesViewController: UIViewController {
    private let viewModel: NamesViewModelType

    private lazy var collectionView: UICollectionView = {
        let layout = SectionKitCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    private lazy var collectionViewAdapter = ListCollectionViewAdapter(
        collectionView: collectionView,
        dataSource: self
    )

    init(viewModel: NamesViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required internal init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        collectionViewAdapter.invalidateDataSource()
    }
}

extension NamesViewController: ListCollectionViewAdapterDataSource {
    internal func sections(for adapter: CollectionViewAdapter) -> [Section] {
        viewModel.sections.map {
            Section(
                id: $0.sectionId,
                model: $0,
                controller: NamesSectionController(model: $0)
            )
        }
    }
}
