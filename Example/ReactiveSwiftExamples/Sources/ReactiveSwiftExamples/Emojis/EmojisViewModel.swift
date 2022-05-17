import Foundation
import ReactiveSwift

internal typealias EmojisViewModelType = EmojisViewModelInputs & EmojisViewModelOutputs

internal protocol EmojisViewModelInputs {
    var shufflePressedObserver: Signal<Void, Never>.Observer { get }
}

internal protocol EmojisViewModelOutputs {
    var title: String { get }
    var emojis: Property<[EmojiViewModelType]> { get }
}

internal struct EmojisViewModel: EmojisViewModelType {
    internal let title = "Emojis"
    internal let emojis: Property<[EmojiViewModelType]>
    internal let (shufflePressedSignal, shufflePressedObserver) = Signal<Void, Never>.pipe()

    internal init() {
        let emojisList = ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉"]
        let emojiViewModels: [EmojiViewModelType] = emojisList.map(EmojiViewModel.init)
        emojis = Property(
            initial: emojiViewModels,
            then: shufflePressedSignal.scan(into: emojiViewModels) { viewModels, _ in viewModels.shuffle() }
        )
    }
}
