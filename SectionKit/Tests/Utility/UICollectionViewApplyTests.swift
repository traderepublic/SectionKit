@testable import SectionKit
import XCTest

@MainActor
internal final class UICollectionViewApplyTests: XCTestCase {
    // MARK: - CollectionViewSectionUpdate

    internal func testSectionUpdateEmptyBatchOperations() {
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let update = CollectionViewSectionUpdate<String>(
            controller: BaseSectionController(),
            batchOperations: [],
            setData: { _ in }
        )
        collectionView.apply(update: update, at: 0)
    }

    internal func testSectionUpdateWithoutWindowWithSingleBatchOperation() {
        let setDataExpectation = expectation(description: "Should invoke setData")
        let reloadDataExpectation = expectation(description: "Should invoke reloadData")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = reloadDataExpectation.fulfill

        let update = CollectionViewSectionUpdate<String>(
            controller: BaseSectionController(),
            batchOperations: [
                .init(
                    data: "123",
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            }
        )
        collectionView.apply(update: update, at: 0)

        wait(
            for: [
                setDataExpectation,
                reloadDataExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testSectionUpdateWithoutWindowWithMultipleBatchOperations() {
        let firstSetDataExpectation = expectation(description: "Should invoke setData for first data")
        let secondSetDataExpectation = expectation(description: "Should invoke setData for second data")
        let reloadDataExpectation = expectation(description: "Should invoke reloadData")
        reloadDataExpectation.expectedFulfillmentCount = 2
        let firstCompletionExpectation = expectation(description: "Should invoke completion of first batch operation")
        let secondCompletionExpectation = expectation(description: "Should invoke completion of second batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = reloadDataExpectation.fulfill

        let update = CollectionViewSectionUpdate<String>(
            controller: BaseSectionController(),
            batchOperations: [
                .init(
                    data: "123",
                    completion: { _ in
                        firstCompletionExpectation.fulfill()
                    }
                ),
                .init(
                    data: "456",
                    completion: { _ in
                        secondCompletionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                switch data {
                case "123":
                    firstSetDataExpectation.fulfill()

                case "456":
                    secondSetDataExpectation.fulfill()

                default:
                    XCTFail("Unexpected data: \(data)")
                }
            }
        )
        collectionView.apply(update: update, at: 0)

        wait(
            for: [
                firstSetDataExpectation,
                firstCompletionExpectation,
                secondSetDataExpectation,
                reloadDataExpectation,
                secondCompletionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testSectionUpdateWithWindowWithSingleBatchOperationWithAlwaysReload() {
        let performBatchUpdatesExpectation = expectation(description: "Should invoke performBatchUpdates")
        let setDataExpectation = expectation(description: "Should invoke setData")
        let reloadSectionsExpectation = expectation(description: "Should invoke reloadSections")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._performBatchUpdates = { updates, completion in
            performBatchUpdatesExpectation.fulfill()
            XCTAssertNotNil(updates)
            updates?()
            XCTAssertNotNil(completion)
            completion?(true)
        }
        collectionView._reloadSections = { sections in
            XCTAssertEqual(sections, IndexSet(integer: 0))
            reloadSectionsExpectation.fulfill()
        }

        let window = UIWindow()
        window.addSubview(collectionView)

        let update = CollectionViewSectionUpdate<String>(
            controller: BaseSectionController(),
            batchOperations: [
                // we're setting explicit updates here, but they should be ignored, since update.shouldReload always returns true
                .init(
                    data: "123",
                    deletes: [0],
                    inserts: [1],
                    moves: [Move(at: 2, to: 3)],
                    reloads: [4],
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            },
            shouldReload: { _ in true }
        )
        collectionView.apply(update: update, at: 0)

        wait(
            for: [
                performBatchUpdatesExpectation,
                setDataExpectation,
                reloadSectionsExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testSectionUpdateWithWindowWithSingleBatchOperationWithSeparateUpdates() {
        let performBatchUpdatesExpectation = expectation(description: "Should invoke performBatchUpdates")
        let setDataExpectation = expectation(description: "Should invoke setData")
        let deleteItemsExpectation = expectation(description: "Should invoke deleteItems")
        let insertItemsExpectation = expectation(description: "Should invoke insertItems")
        let moveItemExpectation = expectation(description: "Should invoke moveItem")
        let reloadItemsExpectation = expectation(description: "Should invoke reloadItems")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._performBatchUpdates = { updates, completion in
            performBatchUpdatesExpectation.fulfill()
            XCTAssertNotNil(updates)
            updates?()
            XCTAssertNotNil(completion)
            completion?(true)
        }
        collectionView._deleteItems = { items in
            // deletes should be descending
            XCTAssertEqual(
                items,
                [
                    IndexPath(item: 2, section: 0),
                    IndexPath(item: 1, section: 0),
                    IndexPath(item: 0, section: 0)
                ]
            )
            deleteItemsExpectation.fulfill()
        }
        collectionView._insertItems = { items in
            // inserts should be ascending
            XCTAssertEqual(
                items,
                [
                    IndexPath(item: 3, section: 0),
                    IndexPath(item: 4, section: 0),
                    IndexPath(item: 5, section: 0)
                ]
            )
            insertItemsExpectation.fulfill()
        }
        collectionView._moveItem = { from, to in
            XCTAssertEqual(from, IndexPath(item: 6, section: 0))
            XCTAssertEqual(to, IndexPath(item: 7, section: 0))
            moveItemExpectation.fulfill()
        }
        collectionView._reloadItems = { items in
            // reloads don't have special ordering (inherited by `Set`)
            XCTAssertEqual(
                Set(items),
                Set([
                    IndexPath(item: 9, section: 0),
                    IndexPath(item: 8, section: 0),
                    IndexPath(item: 10, section: 0)
                ])
            )
            reloadItemsExpectation.fulfill()
        }

        let window = UIWindow()
        window.addSubview(collectionView)

        let update = CollectionViewSectionUpdate<String>(
            controller: BaseSectionController(),
            batchOperations: [
                .init(
                    data: "123",
                    deletes: [1, 0, 2],
                    inserts: [4, 3, 5],
                    moves: [Move(at: 6, to: 7)],
                    reloads: [9, 8, 10],
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            },
            shouldReload: { _ in false }
        )
        collectionView.apply(update: update, at: 0)

        wait(
            for: [
                performBatchUpdatesExpectation,
                setDataExpectation,
                deleteItemsExpectation,
                insertItemsExpectation,
                moveItemExpectation,
                reloadItemsExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    // MARK: - CollectionViewUpdate

    internal func testUpdateEmptyBatchOperations() {
        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let update = CollectionViewUpdate<String>(
            batchOperations: [],
            setData: { _ in }
        )
        collectionView.apply(update: update)
    }

    internal func testUpdateWithoutWindowWithSingleBatchOperation() {
        let setDataExpectation = expectation(description: "Should invoke setData")
        let reloadDataExpectation = expectation(description: "Should invoke reloadData")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = reloadDataExpectation.fulfill

        let update = CollectionViewUpdate<String>(
            batchOperations: [
                .init(
                    data: "123",
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            }
        )
        collectionView.apply(update: update)

        wait(
            for: [
                setDataExpectation,
                reloadDataExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testUpdateWithoutWindowWithMultipleBatchOperations() {
        let firstSetDataExpectation = expectation(description: "Should invoke setData for first data")
        let secondSetDataExpectation = expectation(description: "Should invoke setData for second data")
        let reloadDataExpectation = expectation(description: "Should invoke reloadData")
        reloadDataExpectation.expectedFulfillmentCount = 2
        let firstCompletionExpectation = expectation(description: "Should invoke completion of first batch operation")
        let secondCompletionExpectation = expectation(description: "Should invoke completion of second batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._reloadData = reloadDataExpectation.fulfill
        let update = CollectionViewUpdate<String>(
            batchOperations: [
                .init(
                    data: "123",
                    completion: { _ in
                        firstCompletionExpectation.fulfill()
                    }
                ),
                .init(
                    data: "456",
                    completion: { _ in
                        secondCompletionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                switch data {
                case "123":
                    firstSetDataExpectation.fulfill()

                case "456":
                    secondSetDataExpectation.fulfill()

                default:
                    XCTFail("Unexpected data: \(data)")
                }
            }
        )
        collectionView.apply(update: update)

        wait(
            for: [
                firstSetDataExpectation,
                firstCompletionExpectation,
                secondSetDataExpectation,
                reloadDataExpectation,
                secondCompletionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testUpdateWithWindowWithSingleBatchOperationWithAlwaysReload() {
        let setDataExpectation = expectation(description: "Should invoke setData")
        let reloadDataExpectation = expectation(description: "Should invoke reloadData")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._performBatchUpdates = { updates, completion in
            XCTFail("performBatchUpdates should not be called")
        }
        collectionView._reloadData = reloadDataExpectation.fulfill

        let window = UIWindow()
        window.addSubview(collectionView)

        let update = CollectionViewUpdate<String>(
            batchOperations: [
                // we're setting explicit updates here, but they should be ignored, since update.shouldReload always returns true
                .init(
                    data: "123",
                    deletes: [0],
                    inserts: [1],
                    moves: [Move(at: 2, to: 3)],
                    reloads: [4],
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            },
            shouldReload: { _ in true }
        )
        collectionView.apply(update: update)

        wait(
            for: [
                setDataExpectation,
                reloadDataExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }

    internal func testUpdateWithWindowWithSingleBatchOperationWithSeparateUpdates() {
        let performBatchUpdatesExpectation = expectation(description: "Should invoke performBatchUpdates")
        let setDataExpectation = expectation(description: "Should invoke setData")
        let deleteSectionsExpectation = expectation(description: "Should invoke deleteSections")
        let insertSectionsExpectation = expectation(description: "Should invoke insertSections")
        let moveSectionExpectation = expectation(description: "Should invoke moveSection")
        let reloadSectionsExpectation = expectation(description: "Should invoke reloadSections")
        let completionExpectation = expectation(description: "Should invoke completion of batch operation")

        let collectionView = MockCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView._performBatchUpdates = { updates, completion in
            performBatchUpdatesExpectation.fulfill()
            XCTAssertNotNil(updates)
            updates?()
            XCTAssertNotNil(completion)
            completion?(true)
        }
        collectionView._deleteSections = { sections in
            XCTAssertEqual(sections, IndexSet([2, 1, 0]))
            deleteSectionsExpectation.fulfill()
        }
        collectionView._insertSections = { sections in
            XCTAssertEqual(sections, IndexSet([3, 4, 5]))
            insertSectionsExpectation.fulfill()
        }
        collectionView._moveSection = { from, to in
            XCTAssertEqual(from, 6)
            XCTAssertEqual(to, 7)
            moveSectionExpectation.fulfill()
        }
        collectionView._reloadSections = { sections in
            XCTAssertEqual(sections, IndexSet([9, 8, 10]))
            reloadSectionsExpectation.fulfill()
        }

        let window = UIWindow()
        window.addSubview(collectionView)

        let update = CollectionViewUpdate<String>(
            batchOperations: [
                .init(
                    data: "123",
                    deletes: [1, 0, 2],
                    inserts: [4, 3, 5],
                    moves: [Move(at: 6, to: 7)],
                    reloads: [9, 8, 10],
                    completion: { _ in
                        completionExpectation.fulfill()
                    }
                )
            ],
            setData: { data in
                XCTAssertEqual(data, "123")
                setDataExpectation.fulfill()
            },
            shouldReload: { _ in false }
        )
        collectionView.apply(update: update)

        wait(
            for: [
                performBatchUpdatesExpectation,
                setDataExpectation,
                deleteSectionsExpectation,
                insertSectionsExpectation,
                moveSectionExpectation,
                reloadSectionsExpectation,
                completionExpectation
            ],
            timeout: 1,
            enforceOrder: true
        )
    }
}
