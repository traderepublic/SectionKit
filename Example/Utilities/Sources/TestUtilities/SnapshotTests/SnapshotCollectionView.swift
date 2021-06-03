import UIKit

open class SnapshotCollectionView: UICollectionView {
    public init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        backgroundColor = .systemBackground
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open var contentSize: CGSize {
        didSet { invalidateIntrinsicContentSize() }
    }

    override open var intrinsicContentSize: CGSize { contentSize }
}
