import SectionKit
import UIKit

open class SectionSnapshotContainer: UIView {
    public let collectionView = SnapshotCollectionView()
    public let collectionViewAdapter: SingleSectionCollectionViewAdapter

    public init(sectionController: SectionController, width: CGFloat? = nil, parentVC: UIViewController? = nil) {
        struct FakeSectionModel { }
        collectionViewAdapter = SnapshotCollectionViewAdapter(
            viewController: parentVC,
            collectionView: collectionView,
            section: Section(
                id: "",
                model: FakeSectionModel(),
                controller: sectionController
            )
        )
        super.init(frame: .zero)

        setUpViewHierarchy(width: width)
        setNeedsDisplay()
        layoutIfNeeded()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpViewHierarchy(width: CGFloat?) {
        translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])

        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
