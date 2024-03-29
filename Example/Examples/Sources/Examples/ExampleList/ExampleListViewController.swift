import SectionKit
import UIKit

internal final class ExampleListViewController: UIViewController {
    private let viewModel: ExampleListViewModelType

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.headerMode = .supplementary
        config.footerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    internal init(viewModel: ExampleListViewModelType) {
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
        collectionViewAdapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: viewModel.sections.map { model in
                Section(
                    id: model.sectionId,
                    model: model,
                    controller: ExampleSectionController(model: model)
                )
            }
        )
    }

    override internal func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectItems(in: collectionView, animated: animated)
    }
}
