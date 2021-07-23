@testable import SectionKit
import XCTest

internal final class CollectionViewContextSizeTests: XCTestCase {
    internal func testContainerSize() {
        let rect = CGRect(x: 1, y: 2, width: 4, height: 8)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        XCTAssertEqual(context.containerSize, rect.size)
    }

    internal func testContainerInset() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        XCTAssertEqual(context.containerInset, insets)
    }

    internal func testAdjustedContainerInset() {
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        XCTAssertEqual(context.adjustedContainerInset, insets)
    }

    internal func testInsetContainerSize() {
        let rect = CGRect(x: 16, y: 32, width: 64, height: 128)
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.contentInset = insets
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: collectionView,
            errorHandler: AssertionFailureErrorHandler()
        )
        let expectedSize = CGSize(width: 54, height: 123)
        XCTAssertEqual(context.insetContainerSize, expectedSize)
    }
}
