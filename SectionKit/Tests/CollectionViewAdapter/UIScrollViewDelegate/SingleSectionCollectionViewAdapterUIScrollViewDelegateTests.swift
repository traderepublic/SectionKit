@testable import SectionKit
import UIKit
import XCTest

@MainActor
internal final class SingleSectionCollectionViewAdapterUIScrollViewDelegateTests: BaseCollectionViewAdapterUIScrollViewDelegateTests {
    override internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UIScrollViewDelegate {
        try XCTSkipIf(sections.count > 1, "A test with more than one section is skipped.")
        return SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: sections.first,
            viewController: viewController,
            scrollViewDelegate: scrollViewDelegate,
            errorHandler: errorHandler
        )
    }
}
