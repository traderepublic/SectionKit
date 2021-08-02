import SectionKit
import UIKit
import XCTest

@available(iOS 11.0, *)
internal class MockSectionDragDelegate: SectionDragDelegate {
    // MARK: - dragItemsForBeginning

    internal typealias DragItemsForBeginningBlock = (UIDragSession, SectionIndexPath, CollectionViewContext) -> [UIDragItem]

    internal var _dragItemsForBeginning: DragItemsForBeginningBlock = { _, _, _ in
        XCTFail("not implemented")
        return []
    }

    internal func dragItems(
        forBeginning session: UIDragSession,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> [UIDragItem] {
        _dragItemsForBeginning(session, indexPath, context)
    }

    // MARK: - dragItemsForAdding

    internal typealias DragItemsForAddingBlock = (UIDragSession, SectionIndexPath, CGPoint, CollectionViewContext) -> [UIDragItem]

    internal var _dragItemsForAdding: DragItemsForAddingBlock = { _, _, _, _ in
        XCTFail("not implemented")
        return []
    }

    internal func dragItems(
        forAddingTo session: UIDragSession,
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> [UIDragItem] {
        _dragItemsForAdding(session, indexPath, point, context)
    }

    // MARK: - dragSessionWillBegin

    internal typealias DragSessionWillBeginBlock = (UIDragSession, CollectionViewContext) -> Void

    internal var _dragSessionWillBegin: DragSessionWillBeginBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func dragSessionWillBegin(_ session: UIDragSession, in context: CollectionViewContext) {
        _dragSessionWillBegin(session, context)
    }

    // MARK: - dragSessionDidEnd

    internal typealias DragSessionDidEndBlock = (UIDragSession, CollectionViewContext) -> Void

    internal var _dragSessionDidEnd: DragSessionDidEndBlock = { _, _ in
        XCTFail("not implemented")
    }

    internal func dragSessionDidEnd(_ session: UIDragSession, in context: CollectionViewContext) {
        _dragSessionDidEnd(session, context)
    }

    // MARK: - dragPreviewParametersForItem

    internal typealias DragPreviewParametersForItemBlock = (SectionIndexPath, CollectionViewContext) -> UIDragPreviewParameters?

    internal var _dragPreviewParametersForItem: DragPreviewParametersForItemBlock = { _, _ in
        XCTFail("not implemented")
        return nil
    }

    internal func dragPreviewParametersForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UIDragPreviewParameters? {
        _dragPreviewParametersForItem(indexPath, context)
    }
}
