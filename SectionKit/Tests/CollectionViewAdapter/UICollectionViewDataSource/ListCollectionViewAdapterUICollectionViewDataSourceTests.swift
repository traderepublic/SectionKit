@testable import SectionKit
import UIKit
import XCTest

final class ListCollectionViewAdapterUICollectionViewDataSourceTests: BaseCollectionViewAdapterUICollectionViewDataSourceTests {
    @MainActor
    override func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDataSource {
        ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: sections,
            viewController: viewController,
            scrollViewDelegate: scrollViewDelegate,
            errorHandler: errorHandler
        )
    }
}
