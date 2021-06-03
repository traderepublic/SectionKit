import UIKit

/// The delegate of a section
public protocol SectionDelegate: AnyObject {
    // MARK: - Highlight

    /**
     Determines if the item should be highlighted during tracking.
     
     - Parameter indexPath: The index path of the cell to be highlighted.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the item should be highlighted during tracking.
     */
    func shouldHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    /**
     The item with the given index path was highlighted.
     
     - Parameter indexPath: The index path of the cell that was highlighted.

     - Parameter context: The context the delegate is contained in.
     */
    func didHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext)

    /**
     The item with the given index path was unhighlighted.
     
     - Parameter indexPath: The index path of the cell that was unhighlighted.

     - Parameter context: The context the delegate is contained in.
     */
    func didUnhighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext)

    // MARK: - Selection

    /**
     Determines if the item should be selected.
     
     - Parameter indexPath: The index path of the cell to be selected.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the item should be selected.
     */
    func shouldSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    /**
     Determines if the item should be deselected.
     
     - Parameter indexPath: The index path of the cell to be deselected.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the item should be deselected.
     */
    func shouldDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    /**
     The item with the given index path was selected.
     
     - Parameter indexPath: The index path of the cell that was selected.

     - Parameter context: The context the delegate is contained in.
     */
    func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext)

    /**
     The item with the given index path was deselected.
     
     - Parameter indexPath: The index path of the cell that was deselected.

     - Parameter context: The context the delegate is contained in.
     */
    func didDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext)

    // MARK: - Display

    /**
     The given cell is about to be displayed.
     
     - Parameter cell: The cell that is about to be displayed.
     
     - Parameter indexPath: The index path of the cell that is about to be displayed.

     - Parameter context: The context the delegate is contained in.
     */
    func willDisplay(cell: UICollectionViewCell, at indexPath: SectionIndexPath, in context: CollectionViewContext)

    /**
     The given header view is about to be displayed.
     
     - Parameter headerView: The header view that is about to be displayed.
     
     - Parameter indexPath: The index path of the header view that is about to be displayed.

     - Parameter context: The context the delegate is contained in.
     */
    func willDisplay(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    )

    /**
     The given footer view is about to be displayed.
     
     - Parameter footerView: The footer view that is about to be displayed.
     
     - Parameter indexPath: The index path of the footer view that is about to be displayed.

     - Parameter context: The context the delegate is contained in.
     */
    func willDisplay(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    )

    /**
     The given cell was removed from the `UICollectionView`.
     
     - Parameter cell: The cell that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the cell that was removed from the `UICollectionView`.

     - Parameter context: The context the delegate is contained in.
     */
    func didEndDisplaying(cell: UICollectionViewCell, at indexPath: SectionIndexPath, in context: CollectionViewContext)

    /**
     The given header view was removed from the `UICollectionView`.
     
     - Parameter headerView: The header view that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the header view that was removed from the `UICollectionView`.

     - Parameter context: The context the delegate is contained in.
     */
    func didEndDisplaying(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    )

    /**
     The given footer view was removed from the `UICollectionView`.
     
     - Parameter footerView: The footer view that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the footer view that was removed from the `UICollectionView`.

     - Parameter context: The context the delegate is contained in.
     */
    func didEndDisplaying(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    )

    // MARK: - Copy/Paste

    // These methods provide support for copy/paste actions on cells.
    // All three should be implemented if any are.

    /**
     Determines if an action menu should be displayed for the specified item.
     
     - Parameter indexPath: The index path of the item for which the menu should be displayed.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If an action menu should be displayed for the specified item.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func shouldShowMenuForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    /**
     Determines if the given action can be performed on the item with the given index path.
     
     - Parameter action: The action that should be performed.
     
     - Parameter indexPath: The index path of the item on which the action can be performed.
     
     - Parameter sender: The sender that wants to initiate the action.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the given action can be performed on the item with the given index path.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func canPerform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) -> Bool

    /**
     Perform the specified action on the item with the given index path.
     
     - Parameter action: The action that should be performed.
     
     - Parameter indexPath: The index path of the item on which the action should be performed.
     
     - Parameter sender: The sender that initiated the action.

     - Parameter context: The context the delegate is contained in.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func perform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    )

    // MARK: - Focus

    /**
     Determines if the item can be focused.
     
     - Parameter indexPath: The index path of the cell to be focused.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the item can be focused.
     */
    func canFocusItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool

    // MARK: - Spring Loading

    /**
     Determines if the item should be spring loaded.
     
     - Parameter indexPath: The index path of the item to be spring loaded.
     
     - Parameter interactionContext: An object containing contextual information about the spring-loading interaction.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If the item should be spring loaded.
     */
    @available(iOS 11.0, *)
    func shouldSpringLoadItem(
        at indexPath: SectionIndexPath,
        with interactionContext: UISpringLoadedInteractionContext,
        in context: CollectionViewContext
    ) -> Bool

    // MARK: - Multiple Selection

    /**
     Determines if a multi-select gesture is enabled for the given index path.
     
     - Parameter indexPath: The index path of the item for the multi-select gesture.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: If a multi-select gesture is enabled for the given index path.
     */
    @available(iOS 13.0, *)
    func shouldBeginMultipleSelectionInteraction(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool

    /**
     A multi-select gesture started for the given index path.
     
     - Parameter indexPath: The index path of the item where the multi-select gesture started.

     - Parameter context: The context the delegate is contained in.
     */
    @available(iOS 13.0, *)
    func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath, in context: CollectionViewContext)

    /**
     Returns the configuration of a context menu for the given index path.
     
     - Parameter indexPath: The index path of the item for which the context should be displayed.
     
     - Parameter point: The location of the context menu inside the `UICollectionView`.

     - Parameter context: The context the delegate is contained in.
     
     - Returns: The configuration of a context menu for the given index path.
     */
    @available(iOS 13.0, *)
    func contextMenuConfigurationForItem(
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> UIContextMenuConfiguration?
}

extension SectionDelegate {
    // MARK: - Default: Highlight

    public func shouldHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    public func didHighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    public func didUnhighlightItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    // MARK: - Default: Selection

    public func shouldSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    public func shouldDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> Bool { true }

    public func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    public func didDeselectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) { }

    // MARK: - Default: Display

    public func willDisplay(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    public func willDisplay(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    public func willDisplay(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    public func didEndDisplaying(
        cell: UICollectionViewCell,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    public func didEndDisplaying(
        headerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    public func didEndDisplaying(
        footerView: UICollectionReusableView,
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    // MARK: - Default: Copy/Paste

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    public func shouldShowMenuForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool { false }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    public func canPerform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    @available(iOS, introduced: 6.0, deprecated: 13.0)
    public func perform(
        action: Selector,
        forItemAt indexPath: SectionIndexPath,
        withSender sender: Any?,
        in context: CollectionViewContext
    ) { }

    // MARK: - Default: Focus

    public func canFocusItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        shouldSelectItem(at: indexPath, in: context)
    }

    // MARK: - Default: Spring Loading

    @available(iOS 11.0, *)
    public func shouldSpringLoadItem(
        at indexPath: SectionIndexPath,
        with interactionContext: UISpringLoadedInteractionContext,
        in context: CollectionViewContext
    ) -> Bool {
        true
    }

    // MARK: - Default: Multiple Selection

    @available(iOS 13.0, *)
    public func shouldBeginMultipleSelectionInteraction(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> Bool {
        false
    }

    @available(iOS 13.0, *)
    public func didBeginMultipleSelectionInteraction(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) { }

    @available(iOS 13.0, *)
    public func contextMenuConfigurationForItem(
        at indexPath: SectionIndexPath,
        point: CGPoint,
        in context: CollectionViewContext
    ) -> UIContextMenuConfiguration? {
        nil
    }
}
