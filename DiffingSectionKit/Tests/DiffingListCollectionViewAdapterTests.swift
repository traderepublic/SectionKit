@testable import DiffingSectionKit
import SectionKit
import XCTest

internal final class DiffingListCollectionViewAdapterTests: XCTestCase {
    private struct MockSectionModel: Equatable {
        let sectionId: AnyHashable = UUID()
    }

    internal func testCalculateUpdate() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = DiffingListCollectionViewAdapter(collectionView: collectionView)
        let firstModel = MockSectionModel()
        let firstSection = Section(
            id: firstModel.sectionId,
            model: firstModel,
            controller: BaseSectionController()
        )
        let secondModel = MockSectionModel()
        let secondSection = Section(
            id: secondModel.sectionId,
            model: secondModel,
            controller: BaseSectionController()
        )
        let oldData = [firstSection, secondSection]
        let newData = [secondSection]
        let actualUpdate = adapter.calculateUpdate(from: oldData, to: newData)
        let expectedUpdate = CollectionViewUpdate(
            data: newData,
            deletes: [0],
            setData: { _ in }
        )
        XCTAssertEqual(actualUpdate, expectedUpdate)
    }
}

extension Section: Equatable {
    public static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.isContentEqual(to: rhs)
    }
}

extension CollectionViewUpdate: Equatable where CollectionViewData: Equatable {
    public static func == (
        lhs: CollectionViewUpdate<CollectionViewData>,
        rhs: CollectionViewUpdate<CollectionViewData>
    ) -> Bool {
        lhs.batchOperations == rhs.batchOperations
    }
}

extension CollectionViewBatchOperation: Equatable where CollectionViewData: Equatable {
    public static func == (
        lhs: CollectionViewBatchOperation<CollectionViewData>,
        rhs: CollectionViewBatchOperation<CollectionViewData>
    ) -> Bool {
        lhs.data == rhs.data
            && lhs.deletes == rhs.deletes
            && lhs.inserts == rhs.inserts
            && lhs.moves == rhs.moves
            && lhs.reloads == rhs.reloads
    }
}
