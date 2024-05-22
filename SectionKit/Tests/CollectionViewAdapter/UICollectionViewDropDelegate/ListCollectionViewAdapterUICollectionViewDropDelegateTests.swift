@testable import SectionKit
import UIKit
import XCTest

@available(iOS 11.0, *)
final class ListCollectionViewAdapterUICollectionViewDropDelegateTests: BaseCollectionViewAdapterUICollectionViewDropDelegateTests {
    @MainActor
    override internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDropDelegate {
        ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: sections,
            viewController: viewController,
            scrollViewDelegate: scrollViewDelegate,
            errorHandler: errorHandler
        )
    }
}
