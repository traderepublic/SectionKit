import SectionKit
import XCTest

class BaseSectionFlowDelegateTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

   	func skipIfNeeded() throws {
        guard Self.self === BaseSectionFlowDelegateTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func createSectionFlowDelegate() throws -> SectionFlowDelegate {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testSizeForItemWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let layout = UICollectionViewFlowLayout()
        let itemSize = CGSize(width: 1, height: 2)
        layout.itemSize = itemSize
        XCTAssertEqual(
            sectionFlowDelegate.sizeForItem(
                at: indexPath,
                using: layout,
                in: context
            ),
            itemSize
        )
    }

    @MainActor
    func testSizeForItemWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.sizeForItem(
                at: indexPath,
                using: layout,
                in: context
            ),
            CGSize(width: 50, height: 50)
        )
    }

    @MainActor
    func testInsetWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewFlowLayout()
        let sectionInset = UIEdgeInsets(top: 1, left: 2, bottom: 4, right: 8)
        layout.sectionInset = sectionInset
        XCTAssertEqual(
            sectionFlowDelegate.inset(
                using: layout,
                in: context
            ),
            sectionInset
        )
    }

    @MainActor
    func testInsetWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.inset(
                using: layout,
                in: context
            ),
            .zero
        )
    }

    @MainActor
    func testMinimumLineSpacingWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 1
        XCTAssertEqual(
            sectionFlowDelegate.minimumLineSpacing(
                using: layout,
                in: context
            ),
            1
        )
    }

    @MainActor
    func testMinimumLineSpacingWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.minimumLineSpacing(
                using: layout,
                in: context
            ),
            10
        )
    }

    @MainActor
    func testMinimumInteritemSpacingWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        XCTAssertEqual(
            sectionFlowDelegate.minimumInteritemSpacing(
                using: layout,
                in: context
            ),
            1
        )
    }

    @MainActor
    func testMinimumInteritemSpacingWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.minimumInteritemSpacing(
                using: layout,
                in: context
            ),
            10
        )
    }

    @MainActor
    func testReferenceSizeForHeaderWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewFlowLayout()
        let referenceSizeForHeader = CGSize(width: 1, height: 2)
        layout.headerReferenceSize = referenceSizeForHeader
        XCTAssertEqual(
            sectionFlowDelegate.referenceSizeForHeader(
                using: layout,
                in: context
            ),
            referenceSizeForHeader
        )
    }

    @MainActor
    func testReferenceSizeForHeaderWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.referenceSizeForHeader(
                using: layout,
                in: context
            ),
            .zero
        )
    }

    @MainActor
    func testReferenceSizeForFooterWithFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewFlowLayout()
        let referenceSizeForFooter = CGSize(width: 1, height: 2)
        layout.footerReferenceSize = referenceSizeForFooter
        XCTAssertEqual(
            sectionFlowDelegate.referenceSizeForFooter(
                using: layout,
                in: context
            ),
            referenceSizeForFooter
        )
    }

    @MainActor
    func testReferenceSizeForFooterWithoutFlowLayout() throws {
        let sectionFlowDelegate = try createSectionFlowDelegate()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let layout = UICollectionViewLayout()
        XCTAssertEqual(
            sectionFlowDelegate.referenceSizeForFooter(
                using: layout,
                in: context
            ),
            .zero
        )
    }
}
