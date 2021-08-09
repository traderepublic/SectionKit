@testable import SectionKit
import UIKit
import XCTest

@available(iOS 10.0, *)
internal final class ListCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests: BaseCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests {
    override internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = AssertionFailureErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDataSourcePrefetching {
        ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: sections,
            viewController: viewController,
            scrollViewDelegate: scrollViewDelegate,
            errorHandler: errorHandler
        )
    }
}
