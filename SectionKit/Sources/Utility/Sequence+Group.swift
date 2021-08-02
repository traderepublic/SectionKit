import Foundation

extension Sequence {
    @usableFromInline
    internal func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U: [Iterator.Element]] {
        reduce(into: [:]) { groups, element in
            let key = key(element)
            if groups[key]?.append(element) == nil {
                groups[key] = [element]
            }
        }
    }
}
