import SectionKit
import UIKit
import XCTest

internal class MockSectionDropDelegate: SectionDropDelegate {
    // MARK: - canHandle

    internal typealias CanHandleBlock = (UIDropSession, CollectionViewContext) -> Bool

    internal var _canHandle: CanHandleBlock = { _, _ in
        XCTFail("not implemented")
        return true
    }

    internal func canHandle(drop session: UIDropSession, in context: CollectionViewContext) -> Bool {
        _canHandle(session, context)
    }

    // MARK: - dropSessionDidUpdate

    internal typealias DropSessionDidUpdateBlock = (UIDropSession, SectionIndexPath?, CollectionViewContext) -> UICollectionViewDropProposal

    internal var _dropSessionDidUpdate: DropSessionDidUpdateBlock = { _, _ ,_ in
        XCTFail("not implemented")
        return UICollectionViewDropProposal(operation: .forbidden)
    }

    internal func dropSessionDidUpdate(_ session: UIDropSession, at indexPath: SectionIndexPath?, in context: CollectionViewContext) -> UICollectionViewDropProposal {
        _dropSessionDidUpdate(session, indexPath, context)
    }

    // MARK: - performDrop

    internal typealias PerformDropBlock = (SectionIndexPath?, UICollectionViewDropCoordinator, CollectionViewContext) -> Void

    internal var _performDrop: PerformDropBlock = { _, _, _ in
        XCTFail("not implemented")
    }

    internal func performDrop(at indexPath: SectionIndexPath?, with coordinator: UICollectionViewDropCoordinator, in context: CollectionViewContext) {
        _performDrop(indexPath, coordinator, context)
    }

    // MARK: - dropSessionDidEnter

    internal typealias DropSessionDidEnterBlock = (UIDropSession, CollectionViewContext) -> Void

    internal var _dropSessionDidEnter: DropSessionDidEnterBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func dropSessionDidEnter(_ session: UIDropSession, in context: CollectionViewContext) {
        _dropSessionDidEnter(session, context)
    }

    // MARK: - dropSessionDidExit

    internal typealias DropSessionDidExitBlock = (UIDropSession, CollectionViewContext) -> Void

    internal var _dropSessionDidExit: DropSessionDidExitBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func dropSessionDidExit(_ session: UIDropSession, in context: CollectionViewContext) {
        _dropSessionDidExit(session, context)
    }

    // MARK: - dropSessionDidEnd

    internal typealias DropSessionDidEndBlock = (UIDropSession, CollectionViewContext) -> Void

    internal var _dropSessionDidEnd: DropSessionDidEndBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func dropSessionDidEnd(_ session: UIDropSession, in context: CollectionViewContext) {
        _dropSessionDidEnd(session, context)
    }

    // MARK: - dropPreviewParametersForItem

    internal typealias DropPreviewParametersForItemBlock = (SectionIndexPath, CollectionViewContext) -> UIDragPreviewParameters?

    internal var _dropPreviewParametersForItem: DropPreviewParametersForItemBlock = { _, _ in
        XCTFail("not implemented")
        return nil
    }

    internal func dropPreviewParametersForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UIDragPreviewParameters? {
        _dropPreviewParametersForItem(indexPath, context)
    }
}
