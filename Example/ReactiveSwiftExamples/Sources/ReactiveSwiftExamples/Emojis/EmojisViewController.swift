import UIKit
import ReactiveSwift
import SectionKit

internal final class EmojisViewController: UIViewController {
    private let viewModel: EmojisViewModelType

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
        let sectionModel = viewModel
        collectionViewAdapter = SingleSectionCollectionViewAdapter(
            viewController: self,
            collectionView: collectionView,
            section: Section(
                id: "emojis",
                model: sectionModel,
                controller: EmojisSectionController(model: sectionModel)
            )
        )
    }

    @objc
    private func shufflePressed() {
        viewModel.shufflePressedObserver.send(value: ())
    }
}
