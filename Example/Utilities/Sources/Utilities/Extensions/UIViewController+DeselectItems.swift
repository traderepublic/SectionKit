import UIKit

extension UIViewController {
    /// Deselects the currently selected rows, but uses the `transitionCoordinator`
    /// for the animation so it is stoppable, resumable and reversable.
    /// This should be called in `viewWillAppear(animated:)`
    @inlinable
    public func deselectItems(in collectionView: UICollectionView, animated: Bool) {
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems else { return }

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: { _ in
                for indexPath in selectedIndexPaths {
                    collectionView.deselectItem(at: indexPath, animated: true)
                }
            }, completion: { context in
                guard context.isCancelled else { return }
                for indexPath in selectedIndexPaths {
                    collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
                }
            })
        } else {
            for indexPath in selectedIndexPaths {
                collectionView.deselectItem(at: indexPath, animated: animated)
            }
        }
    }
}
