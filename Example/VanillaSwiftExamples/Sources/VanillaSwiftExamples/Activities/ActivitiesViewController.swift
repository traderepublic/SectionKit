import UIKit
import SectionKit

public final class ActivitiesViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = SectionKitCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()

    private lazy var collectionViewAdapter = SingleSectionCollectionViewAdapter(
        collectionView: collectionView,
        viewController: self
    )

    override public func loadView() {
        view = collectionView
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        title = "Activities"

        let activities = Activity.allCases.map(\.text)
        collectionViewAdapter.section = Section(
            id: UUID(),
            model: activities,
            controller: ActivitiesSectionController(model: activities)
        )
    }
}
