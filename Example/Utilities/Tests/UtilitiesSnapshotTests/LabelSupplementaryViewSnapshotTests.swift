import SnapshotTesting
@testable import Utilities
import XCTest

final class LabelSupplementaryViewSnapshotTests: XCTestCase {
    func testShortString() {
        let view = LabelSupplementaryView()
        view.label.text = "Short string"
        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
    }

    func testLongString() {
        let view = LabelSupplementaryView()
        view.label.text = "The text is long long long long long long long long long"
        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize))
    }
}
