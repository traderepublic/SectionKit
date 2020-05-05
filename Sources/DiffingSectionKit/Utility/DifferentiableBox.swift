import Foundation
import DifferenceKit

/**
 A box that implements `Differentiable`.
 
 It can be used as a wrapper for `Differentiable`, when the boxed type doesn't implement it.
 */
open class DifferentiableBox<Item, Identifier>: Differentiable where Identifier: Hashable {
    
    public let item: Item
    
    public let identifier: (Item) -> Identifier
    
    public let equal: (Item, Item) -> Bool
    
    public init(_ item: Item, identifier: @escaping (Item) -> Identifier, equal: @escaping (Item, Item) -> Bool) {
        self.item = item
        self.identifier = identifier
        self.equal = equal
    }
    
    @inlinable
    open var differenceIdentifier: Identifier { identifier(item) }
    
    @inlinable
    open func isContentEqual(to source: DifferentiableBox<Item, Identifier>) -> Bool {
        equal(item, source.item)
    }
}

