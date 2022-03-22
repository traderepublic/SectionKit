import UIKit
import SectionKit

internal final class EmojisViewController: UIViewController {
    private var viewModel: EmojisViewModelType {
        didSet {
            // `shufflePressed` mutates the viewmodel and thus invokes this `didSet` observer.
            // If the viewmodel is a class, the invalidation of the datasource needs to be performed with another solution, e.g. weak delegate.
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

    internal init(viewModel: EmojisViewModelType) {
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
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(shufflePressed)
        )
        collectionViewAdapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: self
        )
    }

    @objc
    private func shufflePressed() {
        viewModel.shufflePressed()
    }
}

extension EmojisViewController: SingleSectionCollectionViewAdapterDataSource {
    func section(for adapter: CollectionViewAdapter) -> Section? {
        let sectionModel = viewModel
        return Section(
            id: "emojis",
            model: sectionModel,
            controller: EmojisSectionController(model: sectionModel)
        )
    }
}
