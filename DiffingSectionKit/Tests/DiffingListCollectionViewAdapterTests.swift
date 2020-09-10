@testable import DiffingSectionKit
import SectionKit
import XCTest

internal final class DiffingListCollectionViewAdapterTests: XCTestCase {
    private struct MockSectionModel: SectionModel, Equatable {
        let sectionId: AnyHashable = UUID()
    }

    internal func testCalculateUpdate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = DiffingListCollectionViewAdapter(viewController: nil, collectionView: collectionView)
        let firstSection = Section(model: MockSectionModel(), controller: BaseSectionController())
        let secondSection = Section(model: MockSectionModel(), controller: BaseSectionController())
        let oldData = [firstSection, secondSection]
        let newData = [secondSection]
        let actualUpdate = adapter.calculateUpdate(from: oldData, to: newData)
        let expectedUpdate = CollectionViewUpdate(changes: [.deleteSection(at: 0)],
                                                  data: newData,
                                                  setData: { _ in })
        XCTAssertEqual(actualUpdate, expectedUpdate)
    }
}

extension Section: Equatable {
    public static func == (lhs: Section, rhs: Section) -> Bool {
        return lhs.isContentEqual(to: rhs)
    }
}

extension CollectionViewUpdate: Equatable where CollectionViewData: Equatable {
    public static func == (lhs: CollectionViewUpdate<CollectionViewData>,
                           rhs: CollectionViewUpdate<CollectionViewData>) -> Bool {
        return lhs.batchOperations == rhs.batchOperations
    }
}

extension CollectionViewBatchOperation: Equatable where CollectionViewData: Equatable {
    public static func == (lhs: CollectionViewBatchOperation<CollectionViewData>,
                           rhs: CollectionViewBatchOperation<CollectionViewData>) -> Bool {
        return lhs.changes == rhs.changes
            && lhs.data == rhs.data
    }
}
