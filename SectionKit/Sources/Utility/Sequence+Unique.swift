import Foundation

extension Sequence {
    internal func unique<T: Hashable>(by selector: (Iterator.Element) throws -> T) rethrows -> [Iterator.Element] {
        var seen: [T: Bool] = [:]
        return try filter { seen.updateValue(true, forKey: try selector($0)) == nil }
    }
}
