@testable import SectionKit
import UIKit
import XCTest

@available(iOS 10.0, *)
final class ListCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests: BaseCollectionViewAdapterUICollectionViewDataSourcePrefetchingTests {
    @MainActor
    override func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
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
