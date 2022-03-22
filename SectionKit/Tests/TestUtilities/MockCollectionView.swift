@testable import SectionKit
import UIKit
import XCTest

internal final class MockCollectionView: UICollectionView {
    // MARK: - reloadData

    internal typealias ReloadDataBlock = () -> Void

    internal lazy var _reloadData: ReloadDataBlock = { }

    override internal func reloadData() {
        _reloadData()
    }

    // MARK: - reloadSections

    internal typealias ReloadSectionsBlock = (IndexSet) -> Void

    internal lazy var _reloadSections: ReloadSectionsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func reloadSections(_ sections: IndexSet) {
        _reloadSections(sections)
    }

    // MARK: - reloadItems

    internal typealias ReloadItemsBlock = ([IndexPath]) -> Void

    internal lazy var _reloadItems: ReloadItemsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func reloadItems(at indexPaths: [IndexPath]) {
        _reloadItems(indexPaths)
    }

    // MARK: - deleteSections

    internal typealias DeleteSectionsBlock = (IndexSet) -> Void

    internal lazy var _deleteSections: DeleteSectionsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func deleteSections(_ sections: IndexSet) {
        _deleteSections(sections)
    }

    // MARK: - deleteItems

    internal typealias DeleteItemsBlock = ([IndexPath]) -> Void

    internal lazy var _deleteItems: DeleteItemsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func deleteItems(at indexPaths: [IndexPath]) {
        _deleteItems(indexPaths)
    }

    // MARK: - insertSections

    internal typealias InsertSectionsBlock = (IndexSet) -> Void

    internal lazy var _insertSections: InsertSectionsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func insertSections(_ sections: IndexSet) {
        _insertSections(sections)
    }

    // MARK: - insertItems

    internal typealias InsertItemsBlock = ([IndexPath]) -> Void

    internal lazy var _insertItems: InsertItemsBlock = { _ in
        XCTFail("not implemented")
    }

    override internal func insertItems(at indexPaths: [IndexPath]) {
        _insertItems(indexPaths)
    }

    // MARK: - moveSection

    internal typealias MoveSectionBlock = (Int, Int) -> Void

    internal lazy var _moveSection: MoveSectionBlock = { _, _ in
        XCTFail("not implemented")
    }

    override internal func moveSection(_ section: Int, toSection newSection: Int) {
        _moveSection(section, newSection)
    }

    // MARK: - moveItem

    internal typealias MoveItemBlock = (IndexPath, IndexPath) -> Void

    internal lazy var _moveItem: MoveItemBlock = { _, _ in
        XCTFail("not implemented")
    }

    override internal func moveItem(at indexPath: IndexPath, to newIndexPath: IndexPath) {
        _moveItem(indexPath, newIndexPath)
    }

    // MARK: - performBatchUpdates

    internal typealias PerformBatchUpdatesBlock = ((() -> Void)?, ((Bool) -> Void)?) -> Void

    internal lazy var _performBatchUpdates: PerformBatchUpdatesBlock = { _, _ in
        XCTFail("not implemented")
    }

    override internal func performBatchUpdates(
        _ updates: (() -> Void)?,
        completion: ((Bool) -> Void)? = nil
    ) {
        _performBatchUpdates(updates, completion)
    }

    // MARK: - registerCell

    internal typealias RegisterCellBlock = (AnyClass?, String) -> Void

    internal lazy var _registerCell: RegisterCellBlock = { _, _ in }

    override internal func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
        _registerCell(cellClass, identifier)
    }

    // MARK: - dequeueReusableCell

    internal typealias DequeueReusableCellBlock = (String, IndexPath) -> UICollectionViewCell

    internal lazy var _dequeueReusableCell: DequeueReusableCellBlock = { _, _ in UICollectionViewCell() }

    override internal func dequeueReusableCell(
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {
        _dequeueReusableCell(identifier, indexPath)
    }

    // MARK: - registerSupplementaryView

    internal typealias RegisterSupplementaryViewBlock = (AnyClass?, String, String) -> Void

    internal lazy var _registerSupplementaryView: RegisterSupplementaryViewBlock = { _, _, _ in }

    override internal func register(
        _ viewClass: AnyClass?,
        forSupplementaryViewOfKind elementKind: String,
        withReuseIdentifier identifier: String
    ) {
        _registerSupplementaryView(viewClass, elementKind, identifier)
    }

    // MARK: - dequeueReusableSupplementaryView

    internal typealias DequeueReusableSupplementaryViewBlock = (String, String, IndexPath) -> UICollectionReusableView

    internal lazy var _dequeueReusableSupplementaryView: DequeueReusableSupplementaryViewBlock = { _, _, _ in UICollectionReusableView() }

    override internal func dequeueReusableSupplementaryView(
        ofKind elementKind: String,
        withReuseIdentifier identifier: String,
        for indexPath: IndexPath
    ) -> UICollectionReusableView {
        _dequeueReusableSupplementaryView(elementKind, identifier, indexPath)
    }

    // MARK: - indexPathForItem

    internal typealias IndexPathForItemBlock = (CGPoint) -> IndexPath?

    internal var _indexPathForItem: IndexPathForItemBlock = { _ in nil }

    override internal func indexPathForItem(at point: CGPoint) -> IndexPath? {
        _indexPathForItem(point)
    }
}
