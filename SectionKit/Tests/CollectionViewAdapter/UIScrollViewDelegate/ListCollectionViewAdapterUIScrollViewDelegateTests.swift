@testable import SectionKit
import UIKit
import XCTest

internal final class ListCollectionViewAdapterUIScrollViewDelegateTests: BaseCollectionViewAdapterUIScrollViewDelegateTests {
    override internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = AssertionFailureErrorHandler()
    ) throws -> CollectionViewAdapter & UIScrollViewDelegate {
        ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: sections,
            viewController: viewController,
            scrollViewDelegate: scrollViewDelegate,
            errorHandler: errorHandler
        )
    }
}
