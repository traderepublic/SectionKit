@testable import SectionKit
import UIKit
import XCTest

class BaseCollectionViewAdapterUICollectionViewDataSourceTests: XCTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        try skipIfNeeded()
    }

    func skipIfNeeded() throws {
        guard Self.self === BaseCollectionViewAdapterUICollectionViewDataSourceTests.self else { return }
        throw XCTSkip("Tests from base class are skipped")
    }

    func createCollectionView(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout? = nil
    ) -> UICollectionView {
        UICollectionView(frame: frame, collectionViewLayout: layout ?? UICollectionViewFlowLayout())
    }

    @MainActor
    func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = MockErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDataSource {
        throw XCTSkip("Tests from base class are skipped")
    }

    @MainActor
    func testNumberOfSections() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertEqual(adapter.numberOfSections?(in: collectionView), 1)
    }

    @MainActor
    func testNumberOfItemsInSection() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._numberOfItems = { _ in 1 }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(adapter.collectionView(collectionView, numberOfItemsInSection: 0), 1)
    }

    @MainActor
    func testNumberOfItemsInSectionWithInvalidIndex() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._numberOfItems = { _ in 1 }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section index 1")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertEqual(adapter.collectionView(collectionView, numberOfItemsInSection: 1), 0)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCellForItem() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._numberOfItems = { _ in 1 }
                        dataSource._cellForItem = { _, _ in
                            MockCollectionViewCell()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssert(
            adapter.collectionView(
                collectionView,
                cellForItemAt: IndexPath(item: 0, section: 0)
            ) is MockCollectionViewCell
        )
    }

    @MainActor
    func testCellForItemWithInvalidSectionIndex() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._numberOfItems = { _ in 1 }
                        dataSource._cellForItem = { _, _ in
                            MockCollectionViewCell()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section index 1")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertFalse(
            adapter.collectionView(
                collectionView,
                cellForItemAt: IndexPath(item: 0, section: 1)
            ) is MockCollectionViewCell
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCellForItemWithInvalidIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._numberOfItems = { _ in 1 }
                        dataSource._cellForItem = { _, _ in
                            MockCollectionViewCell()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertFalse(
            adapter.collectionView(
                collectionView,
                cellForItemAt: IndexPath()
            ) is MockCollectionViewCell
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testViewForSupplementaryElementOfKindHeader() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._headerView = { _, _ in
                            MockCollectionReusableView()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssert(
            adapter.collectionView?(
                collectionView,
                viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                at: IndexPath(item: 0, section: 0)
            ) is MockCollectionReusableView
        )
    }

    @MainActor
    func testViewForSupplementaryElementOfKindWithInvalidSectionIndex() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._headerView = { _, _ in
                            MockCollectionReusableView()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section 1")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertFalse(
            adapter.collectionView?(
                collectionView,
                viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                at: IndexPath(item: 0, section: 1)
            ) is MockCollectionReusableView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testViewForSupplementaryElementOfKindWithInvalidIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._headerView = { _, _ in
                            MockCollectionReusableView()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertFalse(
            adapter.collectionView?(
                collectionView,
                viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                at: IndexPath()
            ) is MockCollectionReusableView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testViewForSupplementaryElementOfKindFooter() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._footerView = { _, _ in
                            MockCollectionReusableView()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssert(
            adapter.collectionView?(
                collectionView,
                viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter,
                at: IndexPath(item: 0, section: 0)
            ) is MockCollectionReusableView
        )
    }

    @MainActor
    func testViewForSupplementaryElementOfKindWithUnsupportedElementKind() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._footerView = { _, _ in
                            MockCollectionReusableView()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .unsupportedSupplementaryViewKind(kind) = error, kind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertFalse(
            adapter.collectionView?(
                collectionView,
                viewForSupplementaryElementOfKind: "test",
                at: IndexPath(item: 0, section: 0)
            ) is MockCollectionReusableView
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCanMoveItemAt() throws {
        let testExpectation = expectation(description: "Should invoke datasource")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._canMoveItem = { indexPath, context in
                            testExpectation.fulfill()
                            return true
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        XCTAssertEqual(adapter.collectionView?(collectionView, canMoveItemAt: IndexPath(item: 0, section: 0)), true)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testMoveItemInSameSectionCallsDataSource() throws {
        let testExpectation = expectation(description: "Should invoke datasource")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._moveItem = { _, _, _ in
                            testExpectation.fulfill()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ]
        )
        adapter.collectionView?(
            collectionView,
            moveItemAt: IndexPath(item: 0, section: 0),
            to: IndexPath(item: 0, section: 0)
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testMoveItemInDifferentSectionNotCallsDataSource() throws {
        let dataSourceExpectation = expectation(description: "Should not invoke datasource")
        dataSourceExpectation.fulfill()
        let errorExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: {
                    let sectionController = MockSectionController()
                    sectionController.dataSource = {
                        let dataSource = MockSectionDataSource()
                        dataSource._moveItem = { _, _, _ in
                            dataSourceExpectation.fulfill()
                        }
                        return dataSource
                    }()
                    return sectionController
                })
            ],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .moveIsNotInTheSameSection(sourceSection, destinationSection) = error,
                      sourceSection == 0,
                      destinationSection == 1
                else {
                    XCTFail("The error should be moveIsNotInTheSameSection")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                errorExpectation.fulfill()
            }
        )
        adapter.collectionView?(
            collectionView,
            moveItemAt: IndexPath(item: 0, section: 0),
            to: IndexPath(item: 0, section: 1)
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testMoveItemWithInvalidSourceIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error, severity in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        adapter.collectionView?(
            collectionView,
            moveItemAt: IndexPath(),
            to: IndexPath(item: 0, section: 1)
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testMoveItemWithInvalidDestinationIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error, severity in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        adapter.collectionView?(
            collectionView,
            moveItemAt: IndexPath(item: 0, section: 1),
            to: IndexPath()
        )
        waitForExpectations(timeout: 1)
    }

    @MainActor
    @available(iOS 14.0, *)
    func testIndexTitlesIsNil() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(collectionView: collectionView)
        XCTAssertNil(adapter.indexTitles?(for: collectionView))
    }

    @MainActor
    @available(iOS 14.0, *)
    func testIndexPathForIndexTitle() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error, severity in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertEqual(
            adapter.collectionView?(collectionView, indexPathForIndexTitle: "", at: 0),
            IndexPath(item: 0, section: 0)
        )
        waitForExpectations(timeout: 1)
    }
}
