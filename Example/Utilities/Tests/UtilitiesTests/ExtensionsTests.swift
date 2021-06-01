@testable import Utilities
import XCTest

final class ExtensionsTests: XCTestCase {
    func testNSDirectionalEdgeInsetsInitWithVerticalHorizontal() {
        let actual = NSDirectionalEdgeInsets(vertical: 1, horizontal: 2)
        let expected = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        XCTAssertEqual(actual, expected)
    }
}
