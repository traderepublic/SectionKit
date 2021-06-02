@testable import VanillaSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

final class ColorsSectionControllerSnapshotTests: XCTestCase {
    func testDefaultViewModel() {
        let model = ColorsViewModel(colors: [.red, .green, .blue], navigation: MockColorsSectionNavigation())
        let sectionController = ColorsSectionController(model: model)
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}

private struct MockColorsSectionNavigation: ColorsNavigation {
    func show(color: UIColor) { }
}
