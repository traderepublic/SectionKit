import SectionKit
import XCTest

@MainActor
@available(iOS 10.0, *)
internal class BaseSectionDataSourcePrefetchingDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    internal func skipIfNeeded() throws {
        guard Self.self === BaseSectionDataSourcePrefetchingDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func createSectionDataSourcePrefetchingDelegate() throws -> SectionDataSourcePrefetchingDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    internal func testPrefetchItems() throws {
        let sectionDataSourcePrefetchingDelegate = try createSectionDataSourcePrefetchingDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        sectionDataSourcePrefetchingDelegate.prefetchItems(at: [], in: context)
    }

    internal func testCancelPrefetchingForItems() throws {
        let sectionDataSourcePrefetchingDelegate = try createSectionDataSourcePrefetchingDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        sectionDataSourcePrefetchingDelegate.cancelPrefetchingForItems(at: [], in: context)
    }
}
