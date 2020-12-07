import Foundation

extension Collection where Element: Hashable {
    internal func isUnique() -> Bool {
        Set(self).count == count
    }
}
