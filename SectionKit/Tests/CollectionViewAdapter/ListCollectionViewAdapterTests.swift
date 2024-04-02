@testable import SectionKit
import XCTest

final class ListCollectionViewAdapterTests: XCTestCase {
    // MARK: - Init with datasource

    @MainActor
    func testInitWithDataSourceSetsDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(adapter.dataSource === dataSource)
    }

    @MainActor
    func testInitWithDataSourceSetsViewController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let viewController = UIViewController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            viewController: viewController
        )
        XCTAssert(adapter.context.viewController === viewController)
    }

    @MainActor
    func testInitWithDataSourceSetsScrollViewDelegate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let scrollViewDelegate = MockScrollViewDelegate()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssert(adapter.scrollViewDelegate === scrollViewDelegate)
    }

    @MainActor
    func testInitWithDataSourceSetsErrorHandler() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let errorHandler = MockErrorHandler()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            errorHandler: errorHandler
        )
        XCTAssert(adapter.context.errorHandler is MockErrorHandler)
    }

    @MainActor
    func testInitWithDataSourceRetrievesInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [section] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === section)
    }

    @MainActor
    func testInitWithDataSourceSetsContextOnInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [section] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(section.controller.context === adapter.context)
    }

    @MainActor
    func testInitWithDataSourceSetsCollectionViewDataSourceToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dataSource === adapter)
    }

    @MainActor
    @available(iOS 10.0, *)
    func testInitWithDataSourceSetsCollectionViewDataSourcePrefetchingToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.prefetchDataSource === adapter)
    }

    @MainActor
    @available(iOS 10.0, *)
    func testInitWithDataSourceEnablesDataSourcePrefetchingOnCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let _ = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.isPrefetchingEnabled)
    }

    @MainActor
    func testInitWithDataSourceSetsCollectionViewDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.delegate === adapter)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testInitWithDataSourceSetsCollectionViewDragDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dragDelegate === adapter)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testInitWithDataSourceSetsCollectionViewDropDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dropDelegate === adapter)
    }

    @MainActor
    func testInitWithDataSourceSetsContextAdapterToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in [] }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert((adapter.context as? MainCollectionViewContext)?.adapter === adapter)
    }

    // MARK: - Init with sections

    @MainActor
    func testInitWithSectionsDoesNotSetDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssertNil(adapter.dataSource)
    }

    @MainActor
    func testInitWithSectionsSetsViewController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let viewController = UIViewController()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [],
            viewController: viewController
        )
        XCTAssert(adapter.context.viewController === viewController)
    }

    @MainActor
    func testInitWithSectionsSetsScrollViewDelegate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let scrollViewDelegate = MockScrollViewDelegate()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [],
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssert(adapter.scrollViewDelegate === scrollViewDelegate)
    }

    @MainActor
    func testInitWithSectionsSetsErrorHandler() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let errorHandler = MockErrorHandler()
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [],
            errorHandler: errorHandler
        )
        XCTAssert(adapter.context.errorHandler is MockErrorHandler)
    }

    @MainActor
    func testInitWithSectionsSetsInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [section]
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === section)
    }

    @MainActor
    func testInitWithSectionsSetsContextOnInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [section]
        )
        XCTAssert(section.controller.context === adapter.context)
    }

    @MainActor
    func testInitWithSectionsSetsCollectionViewDataSourceToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.dataSource === adapter)
    }

    @MainActor
    @available(iOS 10.0, *)
    func testInitWithSectionsSetsCollectionViewDataSourcePrefetchingToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.prefetchDataSource === adapter)
    }

    @MainActor
    @available(iOS 10.0, *)
    func testInitWithSectionsEnablesDataSourcePrefetchingOnCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let _ = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.isPrefetchingEnabled)
    }

    @MainActor
    func testInitWithSectionsSetsCollectionViewDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.delegate === adapter)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testInitWithSectionsSetsCollectionViewDragDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.dragDelegate === adapter)
    }

    @MainActor
    @available(iOS 11.0, *)
    func testInitWithSectionsSetsCollectionViewDropDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert(collectionView.dropDelegate === adapter)
    }

    @MainActor
    func testInitWithSectionsSetsContextAdapterToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: []
        )
        XCTAssert((adapter.context as? MainCollectionViewContext)?.adapter === adapter)
    }

    // MARK: - Weak references

    @MainActor
    func testDataSourceIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: MockListCollectionViewAdapterDataSource { _ in [] }
        )
        XCTAssertNil(adapter.dataSource)
    }

    @MainActor
    func testViewControllerIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            viewController: UIViewController()
        )
        XCTAssertNil(adapter.context.viewController)
    }

    @MainActor
    func testScrollViewDelegateIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: MockScrollViewDelegate()
        )
        XCTAssertNil(adapter.scrollViewDelegate)
    }

    // MARK: - Setting CollectionViewSections

    @MainActor
    func testSetCollectionViewSectionsUpdatesContextOnSectionController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let initialSection = Section(id: "", model: "", controller: MockSectionController())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [initialSection]
        )
        let newSection = Section(id: "", model: "", controller: MockSectionController())
        adapter.collectionViewSections = [newSection]
        XCTAssertNil(initialSection.controller.context)
        XCTAssert(newSection.controller.context === adapter.context)
    }

    @MainActor
    func testInitialSectionsFiltersDuplicateSectionsAndInvokeErrorHandler() {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let firstSection = Section(id: "", model: "", controller: MockSectionController())
        let secondSection = Section(id: "", model: "", controller: MockSectionController())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [firstSection, secondSection],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .duplicateSectionIds(ids) = error else {
                    XCTFail("The error should be duplicateSectionIds")
                    return
                }
                XCTAssertEqual(ids, [""])
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === firstSection)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testSectionsPropertyFiltersDuplicateSectionsAndInvokesErrorHandler() {
        let testExpectation = expectation(description: "Should invoke errorHandler")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let firstSection = Section(id: "", model: "", controller: MockSectionController())
        let secondSection = Section(id: "", model: "", controller: MockSectionController())
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [],
            errorHandler: MockErrorHandler { error, severity in
                guard case let .duplicateSectionIds(ids) = error else {
                    XCTFail("The error should be duplicateSectionIds")
                    return
                }
                XCTAssertEqual(ids, [""])
                XCTAssertEqual(severity, .nonCritical)
                testExpectation.fulfill()
            }
        )
        adapter.sections = [firstSection, secondSection]
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === firstSection)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testSectionsPropertyFiltersDuplicateSectionsAndInvokesDidUpdateOnlyOnce() {
        let didUpdateExpectation = expectation(description: "Should invoke SectionController.didUpdate exactly once")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let sectionId = "test"

        /*
         The initial array only contains the `initialSection` and the array is then updated with `firstSection` and
         `secondSection`. All three sections have the same id and the expected behaviour would be, that the initial
         sectioncontroller is reused when updating the array. When setting `[firstSection, secondSection]`, the code
         should filter out `secondSection` and subsequently call `didUpdate` only once.
         */

        let createInitialSectionController: () -> SectionController = {
             let sectionController = MockSectionController()
             sectionController._didUpdate = { _ in didUpdateExpectation.fulfill() }
             return sectionController
         }
        let initialSection = Section(id: sectionId, model: "", controller: createInitialSectionController)

        let createConsecutiveSectionController: () -> SectionController = {
            XCTFail("Should reuse initial sectioncontroller")
            return MockSectionController()
        }
        let firstSection = Section(id: sectionId, model: "", controller: createConsecutiveSectionController)
        let secondSection = Section(id: sectionId, model: "", controller: createConsecutiveSectionController)

        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [initialSection],
            errorHandler: MockErrorHandler { _, _ in }
        )
        adapter.sections = [firstSection, secondSection]
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === firstSection)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testSettingTheDataSourceRetrievesTheListOfSections() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockListCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return [section]
        }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView
        )
        adapter.dataSource = dataSource
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testUpdatingTheSectionsReusesSectionControllersWithTheSameId() {
        let testExpectation = expectation(description: "Should invoke didUpdate on the first SectionController")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let firstSection = Section(id: "section", model: "1", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { model in
                XCTAssertEqual(model as? String, "2")
                testExpectation.fulfill()
            }
            return sectionController
        })
        let secondSection = Section(id: firstSection.id, model: "2", controller: {
            XCTFail("Second sectioncontroller should not be constructed")
            return MockSectionController()
        })
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [firstSection]
        )
        adapter.sections = [secondSection]
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first?.controller === firstSection.controller)
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testUpdatingTheSectionsCalculatesAnUpdate() {
        let testExpectation = expectation(description: "Should invoke calculateUpdate on the adapter")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let firstSection = Section(id: "section", model: "1", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { _ in }
            return sectionController
        })
        let secondSection = Section(id: firstSection.id, model: "2", controller: {
            XCTFail("Second sectioncontroller should not be constructed")
            return MockSectionController()
        })

        class CustomListCollectionViewAdapter: ListCollectionViewAdapter {
            // need to be declared here again because this instance can't access the variables from the outer scope
            var firstSection: Section?
            var secondSection: Section?
            var expectation: XCTestExpectation?

            override func calculateUpdate(
                from oldData: [Section],
                to newData: [Section]
            ) -> CollectionViewUpdate<[Section]>? {
                XCTAssertEqual(oldData.count, 1)
                XCTAssert(oldData.first === firstSection)
                XCTAssertEqual(newData.count, 1)
                XCTAssert(newData.first === secondSection)
                expectation?.fulfill()
                return nil
            }
        }
        let adapter = CustomListCollectionViewAdapter(
            collectionView: collectionView,
            sections: [firstSection]
        )
        adapter.firstSection = firstSection
        adapter.secondSection = secondSection
        adapter.expectation = testExpectation

        adapter.sections = [secondSection]
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testCallingInvalidateDataSourceRetrievesTheListOfSections() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        testExpectation.expectedFulfillmentCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { _ in }
            return sectionController
        })
        let dataSource = MockListCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return [section]
        }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        adapter.invalidateDataSource()
        waitForExpectations(timeout: 1)
    }

    @MainActor
    func testResettingDataSourceDoesNotRetrieveTheListOfSectionsAgain() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { _ in }
            return sectionController
        })
        let dataSource = MockListCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return [section]
        }
        let adapter = ListCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        adapter.dataSource = nil
        waitForExpectations(timeout: 1)
    }

    // MARK: - calculateUpdate

    @MainActor
    func testCalculateUpdateReloadsData() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(adapter.calculateUpdate(from: [], to: []))
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssert(update.shouldReload(batchOperation))
    }

    @MainActor
    func testCalculateUpdateHasCorrectData() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        let section = Section(id: "1", model: "", controller: MockSectionController())
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: [],
                to: [section]
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssertEqual(batchOperation.data.count, 1)
        XCTAssert(batchOperation.data.first === section)
    }

    @MainActor
    func testCalculateUpdateSetDataSetsCollectionViewSection() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = ListCollectionViewAdapter(collectionView: collectionView)
        let section = Section(id: "1", model: "", controller: MockSectionController())
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: [],
                to: [section]
            )
        )
        XCTAssert(adapter.collectionViewSections.isEmpty)
        update.setData([section])
        XCTAssertEqual(adapter.collectionViewSections.count, 1)
        XCTAssert(adapter.collectionViewSections.first === section)
    }
}
