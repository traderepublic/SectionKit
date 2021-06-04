import SnapshotTesting
@testable import Utilities
import XCTest

final class LabelCellSnapshotTests: XCTestCase {
    func testShortString() {
        let cell = LabelCell()
        cell.label.text = "Short string"
        assertSnapshot(matching: cell, as: .image(size: cell.intrinsicContentSize))
    }

    func testLongString() {
        let cell = LabelCell()
        cell.label.text = "The text is long long long long long long long long long"
        assertSnapshot(matching: cell, as: .image(size: cell.intrinsicContentSize))
    }
}
