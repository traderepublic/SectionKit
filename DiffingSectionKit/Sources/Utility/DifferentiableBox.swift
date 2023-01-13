import DifferenceKit
import Foundation

@MainActor
public struct DifferentiableBox<Value, Id: Hashable> {
    public let value: Value

    @usableFromInline
    internal let id: @MainActor (Value) -> Id

    @usableFromInline
    internal let isContentEqual: @MainActor (Value, Value) -> Bool

    public init(value: Value, id: @escaping @MainActor (Value) -> Id, isContentEqual: @escaping @MainActor (Value, Value) -> Bool) {
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
