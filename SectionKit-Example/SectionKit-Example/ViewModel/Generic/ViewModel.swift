import Foundation
import ReactiveCocoa
import ReactiveSwift

open class ViewModel {

    // MARK: - Properties
    public let lifetime: Lifetime
    private let token: Lifetime.Token

    public let id: UUID = UUID()

    // MARK: - Initialization
    public init() {
        (lifetime, token) = Lifetime.make()
    }
}

// MARK: - ViewModel+Hashable
extension ViewModel: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - ViewModel+Equatable
extension ViewModel: Equatable {
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
