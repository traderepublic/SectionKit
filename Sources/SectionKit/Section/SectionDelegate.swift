import UIKit

/// The delegate of a section
public protocol SectionDelegate {
    
    // MARK: - Highlight
    
    /**
     Determines if the item should be highlighted during tracking.
     
     - Parameter indexPath: The index path of the cell to be highlighted.
     
     - Returns: If the item should be highlighted during tracking.
     */
    func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool
    
    /**
     The item with the given index path was highlighted.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     */
    func didHighlightItem(at indexPath: SectionIndexPath)
    
    /**
     The item with the given index path was unhighlighted.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     */
    func didUnhighlightItem(at indexPath: SectionIndexPath)
    
    // MARK: - Selection
    
    /**
     Determines if the item should be selected.
     
     - Parameter indexPath: The index path of the cell to be selected.
     
     - Returns: If the item should be selected.
     */
    func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool
    
    /**
     Determines if the item should be deselected.
     
     - Parameter indexPath: The index path of the cell to be deselected.
     
     - Returns: If the item should be deselected.
     */
    func shouldDeselectItem(at indexPath: SectionIndexPath) -> Bool
    
    /**
     The item with the given index path was selected.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     */
    func didSelectItem(at indexPath: SectionIndexPath)
    
    /**
     The item with the given index path was deselected.
     
     - Parameter indexPath: The index path of the cell that was highlighted.
     */
    func didDeselectItem(at indexPath: SectionIndexPath)
    
    // MARK: - Display
    
    /**
     The given cell is about to be displayed.
     
     - Parameter cell: The cell that is about to be displayed.
     
     - Parameter indexPath: The index path of the cell that is about to be displayed.
     */
    func willDisplay(cell: UICollectionViewCell,
                     at indexPath: SectionIndexPath)
    
    /**
     The given supplementary view is about to be displayed.
     
     - Parameter supplementaryView: The supplementary view that is about to be displayed.
     
     - Parameter kind: The kind of the supplementary view that is about to be displayed.
     
     - Parameter indexPath: The index path of the supplementary view that is about to be displayed.
     */
    func willDisplay(supplementaryView: UICollectionReusableView,
                     for kind: SectionSupplementaryViewKind,
                     at indexPath: SectionIndexPath)
    
    /**
     The given cell was removed from the `UICollectionView`.
     
     - Parameter cell: The cell that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the supplementary view that is about to be displayed.
     */
    func didEndDisplaying(cell: UICollectionViewCell,
                          at indexPath: SectionIndexPath)
    
    /**
     The given supplementary view was removed from the `UICollectionView`.
     
     - Parameter supplementaryView: The supplementary view that was removed from the `UICollectionView`.
     
     - Parameter kind: The kind of the supplementary view that was removed from the `UICollectionView`.
     
     - Parameter indexPath: The index path of the supplementary view that was removed from the `UICollectionView`.
     */
    func didEndDisplaying(supplementaryView: UICollectionReusableView,
                          for kind: SectionSupplementaryViewKind,
                          at indexPath: SectionIndexPath)
    
    // MARK: - Copy/Paste
    
    // These methods provide support for copy/paste actions on cells.
    // All three should be implemented if any are.
    
    /**
     Determines if an action menu should be displayed for the specified item.
     
     - Parameter indexPath: The index path of the item for which the menu should be displayed.
     
     - Returns: If an action menu should be displayed for the specified item.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func shouldShowMenuForItem(at indexPath: SectionIndexPath) -> Bool
    
    /**
     Determines if the given action can be performed on the item with the given index path.
     
     - Parameter action: The action that should be performed.
     
     - Parameter indexPath: The index path of the item on which the action can be performed.
     
     - Parameter sender: The sender that wants to initiate the action.
     
     - Returns: If the given action can be performed on the item with the given index path.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func canPerform(action: Selector,
                    forItemAt indexPath: SectionIndexPath,
                    withSender sender: Any?) -> Bool
    
    /**
     Perform the specified action on the item with the given index path.
     
     - Parameter action: The action that should be performed.
     
     - Parameter indexPath: The index path of the item on which the action should be performed.
     
     - Parameter sender: The sender that initiated the action.
     */
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func perform(action: Selector,
                 forItemAt indexPath: SectionIndexPath,
                 withSender sender: Any?)
    
    // MARK: - Focus
    
    /**
     Determines if the item can be focused.
     
     - Parameter indexPath: The index path of the cell to be focused.
     
     - Returns: If the item can be focused.
     */
    func canFocusItem(at indexPath: SectionIndexPath) -> Bool
    
    // MARK: - Spring Loading
    
    /**
     Determines if the item should be spring loaded.
     
     - Parameter indexPath: The index path of the item to be spring loaded.
     
     - Parameter context: An object containing contextual information about the spring-loading interaction.
     
     - Returns: If the item should be spring loaded.
     */
    @available(iOS 11.0, *)
    func shouldSpringLoadItem(at indexPath: SectionIndexPath,
                              with context: UISpringLoadedInteractionContext) -> Bool
    
    // MARK: - Multiple Selection
    
    /**
     Determines if a multi-select gesture is enabled for the given index path.
     
     - Parameter indexPath: The index path of the item for the multi-select gesture.
     
     - Returns: If a multi-select gesture is enabled for the given index path.
     */
    @available(iOS 13.0, *)
    func shouldBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) -> Bool
    
    /**
     A multi-select gesture started for the given index path.
     
     - Parameter indexPath: The index path of the item where the multi-select gesture started.
     */
    @available(iOS 13.0, *)
    func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath)
    
    /**
     Returns the configuration of a context menu for the given index path.
     
     - Parameter indexPath: The index path of the item for which the context should be displayed.
     
     - Parameter point: The location of the context menu inside the `UICollectionView`.
     
     - Returns: If the item should be deselected.
     */
    @available(iOS 13.0, *)
    func contextMenuConfigurationForItem(at indexPath: SectionIndexPath,
                                         point: CGPoint) -> UIContextMenuConfiguration?
}

public extension SectionDelegate {
    
    // MARK: - Default: Highlight
    
    func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        return true
    }
    
    func didHighlightItem(at indexPath: SectionIndexPath) {
        
    }
    
    func didUnhighlightItem(at indexPath: SectionIndexPath) {
        
    }
    
    // MARK: - Default: Selection
    
    func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        return true
    }
    
    func shouldDeselectItem(at indexPath: SectionIndexPath) -> Bool {
        return true
    }
    
    func didSelectItem(at indexPath: SectionIndexPath) {
        
    }
    
    func didDeselectItem(at indexPath: SectionIndexPath) {
        
    }
    
    // MARK: - Default: Display
    
    func willDisplay(cell: UICollectionViewCell,
                     at indexPath: SectionIndexPath) {
        
    }
    
    func willDisplay(supplementaryView: UICollectionReusableView,
                     for kind: SectionSupplementaryViewKind,
                     at indexPath: SectionIndexPath) {
        
    }
    
    func didEndDisplaying(cell: UICollectionViewCell,
                          at indexPath: SectionIndexPath) {
        
    }
    
    func didEndDisplaying(supplementaryView: UICollectionReusableView,
                          for kind: SectionSupplementaryViewKind,
                          at indexPath: SectionIndexPath) {
        
    }
    
    // MARK: - Default: Copy/Paste
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func shouldShowMenuForItem(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func canPerform(action: Selector,
                    forItemAt indexPath: SectionIndexPath,
                    withSender sender: Any?) -> Bool {
        return false
    }
    
    @available(iOS, introduced: 6.0, deprecated: 13.0)
    func perform(action: Selector,
                 forItemAt indexPath: SectionIndexPath,
                 withSender sender: Any?) {
        
    }
    
    // MARK: - Default: Focus
    
    func canFocusItem(at indexPath: SectionIndexPath) -> Bool {
        return shouldSelectItem(at: indexPath)
    }
    
    // MARK: - Default: Spring Loading
    
    @available(iOS 11.0, *)
    func shouldSpringLoadItem(at indexPath: SectionIndexPath,
                              with context: UISpringLoadedInteractionContext) -> Bool {
        return true
    }
    
    // MARK: - Default: Multiple Selection
    
    @available(iOS 13.0, *)
    func shouldBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) -> Bool {
        return false
    }
    
    @available(iOS 13.0, *)
    func didBeginMultipleSelectionInteraction(at indexPath: SectionIndexPath) {
        
    }
    
    @available(iOS 13.0, *)
    func contextMenuConfigurationForItem(at indexPath: SectionIndexPath,
                                         point: CGPoint) -> UIContextMenuConfiguration? {
        return nil
    }
}

