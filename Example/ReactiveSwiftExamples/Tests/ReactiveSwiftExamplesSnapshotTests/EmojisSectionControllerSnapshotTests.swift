@testable import ReactiveSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

@MainActor
final class EmojisSectionControllerSnapshotTests: XCTestCase {
    func testDefaultViewModel() {
        let sectionController = EmojisSectionController(model: EmojisViewModel())
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}
