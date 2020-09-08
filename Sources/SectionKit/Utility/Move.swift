import Foundation

public struct Move: Hashable {
    public let at: Int
    public let to: Int

    public init(at: Int, to: Int) {
        self.at = at
        self.to = to
    }
}
