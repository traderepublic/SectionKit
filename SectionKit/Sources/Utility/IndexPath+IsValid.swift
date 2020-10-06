import Foundation

extension IndexPath {
    internal func isSectionIndexValid(for sections: [Any]) -> Bool {
        count == 2 // precondition of the `section` property
            && section >= 0
            && section < sections.count

    }

    internal func isItemIndexValid(for items: [Any]) -> Bool {
        count == 2 // precondition of the `item` property
            && item >= 0
            && item < items.count
    }
}
