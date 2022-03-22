import Foundation

internal typealias EmojisViewModelType = EmojisViewModelInputs & EmojisViewModelOutputs

internal protocol EmojisViewModelInputs {
    mutating func shufflePressed()
}

internal protocol EmojisViewModelOutputs {
    var title: String { get }
    var emojis: [String] { get }
}

internal struct EmojisViewModel: EmojisViewModelType {
    internal let title = "Emojis"
    internal var emojis = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉"]

    mutating func shufflePressed() {
        emojis.shuffle()
    }
}
