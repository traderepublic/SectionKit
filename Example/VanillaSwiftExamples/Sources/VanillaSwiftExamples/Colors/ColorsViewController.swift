import UIKit
import SectionKit

public final class ColorsViewController: UIViewController {
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

    override public func loadView() {
        view = collectionView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Colors"
        let colors: [UIColor] = [
            .systemYellow,
            .systemOrange,
            .systemRed,
            .systemPink,
            .systemPurple,
            .systemIndigo,
            .systemTeal,
            .systemBlue,
            .systemGreen,
            .white,
            .systemGray,
            .systemGray2,
            .systemGray3,
            .systemGray4,
            .systemGray5,
            .systemGray6,
            .black
        ]
        collectionViewAdapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: Section(
                id: "colors",
                model: colors,
                controller: ColorsSectionController(model: colors)
            ),
            viewController: self
        )
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        deselectItems(in: collectionView, animated: animated)
    }
}
