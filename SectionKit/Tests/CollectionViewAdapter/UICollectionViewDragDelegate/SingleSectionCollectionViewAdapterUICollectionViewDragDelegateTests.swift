@testable import SectionKit
import UIKit
import XCTest

@available(iOS 11.0, *)
final class SingleSectionCollectionViewAdapterUICollectionViewDragDelegateTests: BaseCollectionViewAdapterUICollectionViewDragDelegateTests {
    @MainActor
    override func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDragDelegate {
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
