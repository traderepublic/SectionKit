import UIKit

extension CollectionViewContext {
    /// The size of the `UICollectionView`.
    @inlinable
    public var containerSize: CGSize {
        collectionView.bounds.size
    }

    /// The custom distance that the content view is inset from the safe area or scroll view edges.
    @inlinable
    public var customContainerInset: UIEdgeInsets {
        collectionView.contentInset
    }

    /// The insets derived from the content insets and the safe area of the scroll view.
    @available(iOS 11.0, *)
    @inlinable
    public var adjustedContainerInset: UIEdgeInsets {
        collectionView.adjustedContentInset
    }

    /// The size of the `UICollectionView` inset by the `adjustedContainerInset`.
    @available(iOS 11.0, *)
    @inlinable
    public var insetContainerSize: CGSize {
        collectionView.bounds.inset(by: adjustedContainerInset).size
    }
}
