@testable import Utilities
import XCTest

final class LabelCellTests: XCTestCase {
    func testPrepareForReuseClearsLabelText() {
        let cell = LabelCell()
        cell.label.text = "Test"
        cell.prepareForReuse()
        XCTAssertNil(cell.label.text)
    }
}
