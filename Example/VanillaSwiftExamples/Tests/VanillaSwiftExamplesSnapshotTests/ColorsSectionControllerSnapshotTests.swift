@testable import VanillaSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

final class ColorsSectionControllerSnapshotTests: XCTestCase {
    func testDefaultViewModel() {
        let model = MockColorsViewModel()
        let sectionController = ColorsSectionController(model: model)
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}

private struct MockColorsViewModel: ColorsViewModelType {
    let title = ""
    let colors: [UIColor] = [.red, .green, .blue]
    func select(color: UIColor) { }
}
