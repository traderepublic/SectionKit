@testable import SectionKit
import XCTest

final class CollectionViewContextSizeTests: XCTestCase {
    @MainActor
    func testContainerSize() {
        let rect = CGRect(x: 1, y: 2, width: 4, height: 8)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(context.containerSize, rect.size)
    }

    @MainActor
    func testCustomContainerInset() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(context.customContainerInset, insets)
    }

    @MainActor
    func testAdjustedContainerInset() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(context.adjustedContainerInset, insets)
    }

    @MainActor
    func testInsetContainerSize() {
        let rect = CGRect(x: 16, y: 32, width: 64, height: 128)
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: MockErrorHandler()
        )
        let expectedSize = CGSize(width: 54, height: 123)
        XCTAssertEqual(context.insetContainerSize, expectedSize)
    }
}
