@testable import SectionKit
import UIKit
import XCTest

internal class BaseCollectionViewAdapterUICollectionViewDataSourceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }

    internal func createCollectionView(
        frame: CGRect = .zero,
        collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()
    ) -> UICollectionView {
        UICollectionView(frame: frame, collectionViewLayout: layout)
    }

    internal func createCollectionViewAdapter(
        collectionView: UICollectionView,
        sections: [Section] = [],
        viewController: UIViewController? = nil,
        scrollViewDelegate: UIScrollViewDelegate? = nil,
        errorHandler: ErrorHandling = AssertionFailureErrorHandler()
    ) throws -> CollectionViewAdapter & UICollectionViewDataSource {
        fatalError("not implemented")
    }

    internal func testNumberOfSections() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            sections: [
                Section(id: "", model: "", controller: MockSectionController())
            ]
        )
        XCTAssertEqual(adapter.numberOfSections?(in: collectionView), 1)
    }

    internal func testNumberOfItemsInSection() throws {
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

    internal func testNumberOfItemsInSectionWithInvalidIndex() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section index 1")
                    return
                }
                testExpectation.fulfill()
            }
        )
        XCTAssertEqual(adapter.collectionView(collectionView, numberOfItemsInSection: 1), 0)
        waitForExpectations(timeout: 1)
    }

    internal func testCellForItem() throws {
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

    internal func testCellForItemWithInvalidSectionIndex() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section index 1")
                    return
                }
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

    internal func testCellForItemWithInvalidIndexPath() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
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

    internal func testViewForSupplementaryElementOfKindHeader() throws {
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

    internal func testViewForSupplementaryElementOfKindWithInvalidSectionIndex() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .missingDataSource(section: section) = error, section == 1 else {
                    XCTFail("The error should be missingDataSource with section 1")
                    return
                }
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

    internal func testViewForSupplementaryElementOfKindWithInvalidIndexPath() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
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

    internal func testViewForSupplementaryElementOfKindFooter() throws {
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

    internal func testViewForSupplementaryElementOfKindWithUnsupportedElementKind() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .unsupportedSupplementaryViewKind(kind) = error, kind == "test" else {
                    XCTFail("The error should be unsupportedSupplementaryViewKind")
                    return
                }
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

    internal func testCanMoveItemAt() throws {
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

    internal func testMoveItemInSameSectionCallsDataSource() throws {
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

    internal func testMoveItemInDifferentSectionNotCallsDataSource() throws {
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
            errorHandler: MockErrorHandler { error in
                guard case let .moveIsNotInTheSameSection(sourceSection, destinationSection) = error,
                      sourceSection == 0,
                      destinationSection == 1
                else {
                    XCTFail("The error should be moveIsNotInTheSameSection")
                    return
                }
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

    internal func testMoveItemWithInvalidSourceIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
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

    internal func testMoveItemWithInvalidDestinationIndexPath() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case let .invalidIndexPath(indexPath: indexPath) = error, indexPath == IndexPath() else {
                    XCTFail("The error should be invalidIndexPath")
                    return
                }
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

    internal func testIndexTitlesIsNil() throws {
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(collectionView: collectionView)
        XCTAssertNil(adapter.indexTitles?(for: collectionView))
    }

    internal func testIndexPathForIndexTitle() throws {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = createCollectionView()
        let adapter = try createCollectionViewAdapter(
            collectionView: collectionView,
            errorHandler: MockErrorHandler { error in
                guard case .notImplemented = error else {
                    XCTFail("The error should be notImplemented")
                    return
                }
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
