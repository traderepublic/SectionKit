@testable import VanillaSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

final class ColorsSectionControllerSnapshotTests: XCTestCase {
    @MainActor
    func testDefaultViewModel() {
        let sectionController = ColorsSectionController(model: [.red, .green, .blue])
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}
