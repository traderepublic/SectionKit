import Foundation

protocol Stacking {
    associatedtype Element
    
    func peek() -> Element?
    
    mutating func push(_ element: Element)
    
    @discardableResult
    mutating func pop() -> Element?
}

extension Stacking {
    @inlinable
    var isEmpty: Bool { peek() == nil }
}

struct Stack<Element> {
    
    // MARK: - Private properties
    
    // the top element of the stack is the last in the array
    private var storage: [Element]
    
    // MARK: - Init
    
    @inlinable
    init(_ initialValues: [Element] = []) {
        storage = initialValues
    }
}

extension Stack: Stacking {
    @inlinable
    func peek() -> Element? {
        storage.last
    }
    
    @inlinable
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @inlinable
    @discardableResult
    mutating func pop() -> Element? {
        storage.popLast()
    }
}

extension Stack: Equatable where Element: Equatable {
    @inlinable
    static func == (lhs: Stack<Element>, rhs: Stack<Element>) -> Bool {
        lhs.storage == rhs.storage
    }
}

extension Stack: CustomStringConvertible {
    @inlinable
    var description: String { "\(storage)" }
}

extension Stack: ExpressibleByArrayLiteral {
    @inlinable
    init(arrayLiteral elements: Element...) {
        self.init(elements)
    }
}
