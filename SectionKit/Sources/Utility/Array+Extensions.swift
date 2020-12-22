import Foundation

extension Array {
    /// Filter out duplicate elements according to the `key` on the element. The order is preserved
    /// and the element is kept in case of duplicate; the others are omitted from the returned array.
    /// - Parameter key: A KeyPath reference a field on this array's elements.
    /// - Returns: An array whose elements have unique values of the field referenced by `key`
    internal func unique<Value: Hashable>(for key: KeyPath<Element, Value>) -> Self {
        var result: Self = []
        result.reserveCapacity(count)
        var keys = Set<Value>()
        for element in self {
            let (newMember, _) = keys.insert(element[keyPath: key])
            if newMember {
                result.append(element)
            }
        }
        return result
    }
}
