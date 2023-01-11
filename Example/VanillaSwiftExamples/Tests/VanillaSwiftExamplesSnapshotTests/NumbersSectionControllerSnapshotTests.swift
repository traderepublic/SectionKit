@testable import VanillaSwiftExamples
import SnapshotTesting
import TestUtilities
import XCTest

@MainActor
final class NumbersSectionControllerSnapshotTests: XCTestCase {
    func testDefaultViewModel() {
        let model = NumbersSectionViewModel(numbers: Array(0..<10), navigation: MockNumbersSectionNavigation())
        let sectionController = NumbersSectionController(model: model)
        let container = SectionSnapshotContainer(sectionController: sectionController, width: 375)
        assertSnapshot(matching: container, as: .image(size: container.intrinsicContentSize))
    }
}

private struct MockNumbersSectionNavigation: NumbersSectionNavigation {
    func show(number: Int) { }
}
