import Foundation

open class HashableBox<Item, HashableItem>: Hashable where HashableItem: Hashable {
    public static func == (lhs: HashableBox<Item, HashableItem>, rhs: HashableBox<Item, HashableItem>) -> Bool {
        return lhs.hashable(lhs.item).hashValue == rhs.hashable(rhs.item).hashValue
    }
    
    public let item: Item
    
    public let hashable: (Item) -> HashableItem
    
    public init(_ item: Item, hashable: @escaping (Item) -> HashableItem) {
        self.item = item
        self.hashable = hashable
    }
    
    open func hash(into hasher: inout Hasher) {
        hasher.combine(hashable(item))
    }
}
