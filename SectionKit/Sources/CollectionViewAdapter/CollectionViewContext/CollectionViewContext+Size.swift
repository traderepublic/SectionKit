import UIKit

extension CollectionViewContext {
    /// The size of the `UICollectionView`.
    @inlinable
    public var containerSize: CGSize {
        collectionView.bounds.size
    }

    /// The insets of the content view from the safe area or scroll view edges.
    @inlinable
    public var containerInset: UIEdgeInsets {
        collectionView.contentInset
    }

    /// The insets derived from the content insets and the safe area of the scroll view.
    @inlinable
    public var adjustedContainerInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return collectionView.adjustedContentInset
        } else {
            return collectionView.contentInset
        }
    }

    /// The size of the `UICollectionView` inset by the `adjustedContainerInset`.
    @inlinable
    public var insetContainerSize: CGSize {
        collectionView.bounds.inset(by: adjustedContainerInset).size
    }
}
