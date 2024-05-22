import SectionKit
import XCTest

class BaseSectionDataSourceTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseSectionDataSourceTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func createSectionDataSource() throws -> SectionDataSource {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testNumberOfItems() throws {
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        XCTAssertEqual(sectionDataSource.numberOfItems(in: context), 0)
    }

    @MainActor
    func testCellForItem() throws {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error, severity in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionDataSource.cellForItem(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionViewCell.self)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testHeaderView() throws {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error, severity in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionDataSource.headerView(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionReusableView.self)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testFooterView() throws {
        let errorExpectation = expectation(description: "The errorHandler should be called")
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler { error, severity in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssert(
            type(
                of: sectionDataSource.footerView(
                    at: indexPath,
                    in: context
                )
            ) === UICollectionReusableView.self)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCanMoveItem() throws {
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let indexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        XCTAssertFalse(sectionDataSource.canMoveItem(at: indexPath, in: context))
    }

    @MainActor
    func testMoveItem() throws {
        let sectionDataSource = try createSectionDataSource()
        let context = MainCollectionViewContext(
            viewController: nil,
            collectionView: UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()),
            errorHandler: MockErrorHandler()
        )
        let sourceIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        let destinationIndexPath = SectionIndexPath(IndexPath(item: 0, section: 0))
        sectionDataSource.moveItem(at: sourceIndexPath, to: destinationIndexPath, in: context)
    }
}
