import Foundation

extension Sequence {
    /**
     Filter out duplicate elements according to a key returned by the `selector` closure.

     The order is preserved and, in case of a duplicate, the first element of that key is matched.
     The others are omitted from the returned array.

     - Parameter selector: A closure that returns a key, called for every element in this sequence.

     - Throws: Rethrows exceptions from `selector`.

     - Returns: A sequence whose elements have unique values of the field referenced by `key`.
     */
    @usableFromInline
    internal func unique<T: Hashable>(by selector: (Iterator.Element) throws -> T) rethrows -> [Iterator.Element] {
        var seen = Set<T>()
        return try filter {
            let (inserted, _) = seen.insert(try selector($0))
            return inserted
        }
    }
}
