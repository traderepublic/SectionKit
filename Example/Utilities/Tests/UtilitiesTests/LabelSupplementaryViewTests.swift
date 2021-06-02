@testable import Utilities
import XCTest

final class LabelSupplementaryViewTests: XCTestCase {
    func testPrepareForReuseClearsLabelText() {
        let cell = LabelSupplementaryView()
        cell.label.text = "Test"
        cell.prepareForReuse()
        XCTAssertNil(cell.label.text)
    }
}
