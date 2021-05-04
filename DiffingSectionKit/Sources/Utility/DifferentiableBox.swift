import DifferenceKit
import Foundation

public struct DifferentiableBox<Value, Id: Hashable> {
    public let value: Value

    @usableFromInline
    internal let id: (Value) -> Id

    @usableFromInline
    internal let isContentEqual: (Value, Value) -> Bool

    public init(value: Value, id: @escaping (Value) -> Id, isContentEqual: @escaping (Value, Value) -> Bool) {
        self.value = value
        self.id = id
        self.isContentEqual = isContentEqual
    }
}

extension DifferentiableBox: Differentiable {
    @inlinable
    public var differenceIdentifier: Id { id(value) }

    @inlinable
    public func isContentEqual(to source: DifferentiableBox<Value, Id>) -> Bool {
        isContentEqual(value, source.value)
    }
}
