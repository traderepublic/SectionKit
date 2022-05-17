@testable import SectionKit
import XCTest

internal final class SingleSectionCollectionViewAdapterTests: XCTestCase {
    // MARK: - Init with datasource

    internal func testInitWithDataSourceSetsDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(adapter.dataSource === dataSource)
    }

    internal func testInitWithDataSourceSetsViewController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let viewController = UIViewController()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            viewController: viewController
        )
        XCTAssert(adapter.context.viewController === viewController)
    }

    internal func testInitWithDataSourceSetsScrollViewDelegate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let scrollViewDelegate = MockScrollViewDelegate()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssert(adapter.scrollViewDelegate === scrollViewDelegate)
    }

    internal func testInitWithDataSourceSetsErrorHandler() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let errorHandler = MockErrorHandler()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource,
            errorHandler: errorHandler
        )
        XCTAssert(adapter.context.errorHandler is MockErrorHandler)
    }

    internal func testInitWithDataSourceRetrievesInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in section }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === section)
    }

    internal func testInitWithDataSourceSetsContextOnInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in section }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(section.controller.context === adapter.context)
    }

    internal func testInitWithDataSourceSetsCollectionViewDataSourceToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dataSource === adapter)
    }

    @available(iOS 10.0, *)
    internal func testInitWithDataSourceSetsCollectionViewDataSourcePrefetchingToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.prefetchDataSource === adapter)
    }

    @available(iOS 10.0, *)
    internal func testInitWithDataSourceEnablesDataSourcePrefetchingOnCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let _ = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.isPrefetchingEnabled)
    }

    internal func testInitWithDataSourceSetsCollectionViewDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.delegate === adapter)
    }

    @available(iOS 11.0, *)
    internal func testInitWithDataSourceSetsCollectionViewDragDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dragDelegate === adapter)
    }

    @available(iOS 11.0, *)
    internal func testInitWithDataSourceSetsCollectionViewDropDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert(collectionView.dropDelegate === adapter)
    }

    internal func testInitWithDataSourceSetsContextAdapterToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        XCTAssert((adapter.context as? MainCollectionViewContext)?.adapter === adapter)
    }

    // MARK: - Init with sections

    internal func testInitWithSectionsDoesNotSetDataSource() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssertNil(adapter.dataSource)
    }

    internal func testInitWithSectionsSetsViewController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let viewController = UIViewController()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil,
            viewController: viewController
        )
        XCTAssert(adapter.context.viewController === viewController)
    }

    internal func testInitWithSectionsSetsScrollViewDelegate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let scrollViewDelegate = MockScrollViewDelegate()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil,
            scrollViewDelegate: scrollViewDelegate
        )
        XCTAssert(adapter.scrollViewDelegate === scrollViewDelegate)
    }

    internal func testInitWithSectionsSetsErrorHandler() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let errorHandler = MockErrorHandler()
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil,
            errorHandler: errorHandler
        )
        XCTAssert(adapter.context.errorHandler is MockErrorHandler)
    }

    internal func testInitWithSectionsSetsInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: section
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === section)
    }

    internal func testInitWithSectionsSetsContextOnInitialSections() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: section
        )
        XCTAssert(section.controller.context === adapter.context)
    }

    internal func testInitWithSectionsSetsCollectionViewDataSourceToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.dataSource === adapter)
    }

    @available(iOS 10.0, *)
    internal func testInitWithSectionsSetsCollectionViewDataSourcePrefetchingToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.prefetchDataSource === adapter)
    }

    @available(iOS 10.0, *)
    internal func testInitWithSectionsEnablesDataSourcePrefetchingOnCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let _ = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.isPrefetchingEnabled)
    }

    internal func testInitWithSectionsSetsCollectionViewDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.delegate === adapter)
    }

    @available(iOS 11.0, *)
    internal func testInitWithSectionsSetsCollectionViewDragDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.dragDelegate === adapter)
    }

    @available(iOS 11.0, *)
    internal func testInitWithSectionsSetsCollectionViewDropDelegateToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(collectionView.dropDelegate === adapter)
    }

    internal func testInitWithSectionsSetsContextAdapterToSelf() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert((adapter.context as? MainCollectionViewContext)?.adapter === adapter)
    }

    // MARK: - Weak references

    internal func testDataSourceIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: MockSingleSectionCollectionViewAdapterDataSource { _ in nil }
        )
        XCTAssertNil(adapter.dataSource)
    }

    internal func testViewControllerIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            viewController: UIViewController()
        )
        XCTAssertNil(adapter.context.viewController)
    }

    internal func testScrollViewDelegateIsWeakReferenced() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            scrollViewDelegate: MockScrollViewDelegate()
        )
        XCTAssertNil(adapter.scrollViewDelegate)
    }

    // MARK: - Setting CollectionViewSections

    internal func testSetCollectionViewSectionsUpdatesContextOnSectionController() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let initialSection = Section(id: "", model: "", controller: MockSectionController())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: initialSection
        )
        let newSection = Section(id: "", model: "", controller: MockSectionController())
        adapter.collectionViewSection = newSection
        XCTAssertNil(initialSection.controller.context)
        XCTAssert(newSection.controller.context === adapter.context)
    }

    internal func testSettingTheDataSourceRetrievesTheSection() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return section
        }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView
        )
        adapter.dataSource = dataSource
        waitForExpectations(timeout: 1)
    }

    internal func testUpdatingTheSectionsReusesSectionControllersWithTheSameId() {
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
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: firstSection
        )
        adapter.section = secondSection
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first?.controller === firstSection.controller)
        waitForExpectations(timeout: 1)
    }

    internal func testUpdatingTheSectionsCalculatesAnUpdate() {
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

        class CustomSingleSectionCollectionViewAdapter: SingleSectionCollectionViewAdapter {
            // need to be declared here again because this instance can't access the variables from the outer scope
            var firstSection: Section?
            var secondSection: Section?
            var expectation: XCTestExpectation?

            override func calculateUpdate(
                from oldData: Section?,
                to newData: Section?
            ) -> CollectionViewUpdate<Section?>? {
                XCTAssert(oldData === firstSection)
                XCTAssert(newData === secondSection)
                expectation?.fulfill()
                return nil
            }
        }
        let adapter = CustomSingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: firstSection
        )
        adapter.firstSection = firstSection
        adapter.secondSection = secondSection
        adapter.expectation = testExpectation

        adapter.section = secondSection
        waitForExpectations(timeout: 1)
    }

    internal func testCallingInvalidateDataSourceRetrievesTheSection() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        testExpectation.expectedFulfillmentCount = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { _ in }
            return sectionController
        })
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return section
        }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        adapter.invalidateDataSource()
        waitForExpectations(timeout: 1)
    }

    internal func testResettingDataSourceDoesNotRetrieveTheSectionAgain() {
        let testExpectation = expectation(description: "Should invoke dataSource")
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: {
            let sectionController = MockSectionController()
            sectionController._didUpdate = { _ in }
            return sectionController
        })
        let dataSource = MockSingleSectionCollectionViewAdapterDataSource { _ in
            testExpectation.fulfill()
            return section
        }
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            dataSource: dataSource
        )
        adapter.dataSource = nil
        waitForExpectations(timeout: 1)
    }

    internal func testSectionsWhenThereIsASection() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let section = Section(id: "", model: "", controller: MockSectionController())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: section
        )
        XCTAssertEqual(adapter.sections.count, 1)
        XCTAssert(adapter.sections.first === section)
    }

    internal func testSectionsWhenThereIsNoSection() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(
            collectionView: collectionView,
            section: nil
        )
        XCTAssert(adapter.sections.isEmpty)
    }

    // MARK: - calculateUpdate

    internal func testCalculateUpdateFromSomeToSomeWithTheSameId() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: Section(id: "1", model: "", controller: MockSectionController()),
                to: Section(id: "1", model: "", controller: MockSectionController())
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssertFalse(update.shouldReload(batchOperation))
    }

    internal func testCalculateUpdateFromSomeToSomeWithADifferentId() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: Section(id: "1", model: "", controller: MockSectionController()),
                to: Section(id: "2", model: "", controller: MockSectionController())
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssertEqual(batchOperation.reloads, [0])
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssertFalse(update.shouldReload(batchOperation))
    }

    internal func testCalculateUpdateFromNoneToSome() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: nil,
                to: Section(id: "1", model: "", controller: MockSectionController())
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssertEqual(batchOperation.inserts, [0])
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssertFalse(update.shouldReload(batchOperation))
    }

    internal func testCalculateUpdateFromSomeToNone() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: Section(id: "1", model: "", controller: MockSectionController()),
                to: nil
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssertEqual(batchOperation.deletes, [0])
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssertFalse(update.shouldReload(batchOperation))
    }

    internal func testCalculateUpdateFromNoneToNone() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let update = try XCTUnwrap(adapter.calculateUpdate(from: nil, to: nil))
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.deletes.isEmpty)
        XCTAssert(batchOperation.inserts.isEmpty)
        XCTAssert(batchOperation.reloads.isEmpty)
        XCTAssert(batchOperation.moves.isEmpty)
        XCTAssertFalse(update.shouldReload(batchOperation))
    }

    internal func testCalculateUpdateHasCorrectData() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let section = Section(id: "1", model: "", controller: MockSectionController())
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: nil,
                to: section
            )
        )
        XCTAssertEqual(update.batchOperations.count, 1)
        let batchOperation = update.batchOperations.first!
        XCTAssert(batchOperation.data === section)
    }

    internal func testCalculateUpdateSetDataSetsCollectionViewSection() throws {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(collectionView: collectionView)
        let section = Section(id: "1", model: "", controller: MockSectionController())
        let update = try XCTUnwrap(
            adapter.calculateUpdate(
                from: nil,
                to: section
            )
        )
        XCTAssertNil(adapter.collectionViewSection)
        update.setData(section)
        XCTAssert(adapter.collectionViewSection === section)
    }
}
