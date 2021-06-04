import Foundation

internal typealias EmojiViewModelType = EmojiViewModelInputs & EmojiViewModelOutputs

internal protocol EmojiViewModelInputs { }

internal protocol EmojiViewModelOutputs {
    var emoji: String { get }
}

internal struct EmojiViewModel: EmojiViewModelType {
    internal let emoji: String
}
