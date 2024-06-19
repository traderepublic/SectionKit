@testable import ReactiveSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

final class EmojisSectionControllerSnapshotTests: XCTestCase {
    @MainActor
    func testDefaultViewModel() {
        let sectionController = EmojisSectionController(model: EmojisViewModel())
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}
