import UIKit
import SectionKit

internal final class NumbersViewController: UIViewController {
    private let viewModel: NumbersViewModelType

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
        collectionViewAdapter = ListCollectionViewAdapter(
            viewController: self,
            collectionView: collectionView,
            sections: viewModel.sections.map {
                Section(
                    id: $0.sectionId,
                    model: $0,
                    controller: NumbersSectionController(model: $0)
                )
            }
        )
    }
}
