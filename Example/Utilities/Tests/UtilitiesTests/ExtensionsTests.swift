@testable import Utilities
import XCTest

final class ExtensionsTests: XCTestCase {
    func testNSDirectionalEdgeInsetsInitWithVerticalHorizontal() {
        let actual = NSDirectionalEdgeInsets(vertical: 1, horizontal: 2)
        let expected = NSDirectionalEdgeInsets(top: 1, leading: 2, bottom: 1, trailing: 2)
        XCTAssertEqual(actual, expected)
    }

    func testCGSizeAddingPadding() {
        let actual = CGSize(width: 1, height: 2)
            .adding(padding: NSDirectionalEdgeInsets(top: 4, leading: 8, bottom: 16, trailing: 32))
        let expected = CGSize(width: 41, height: 22)
        XCTAssertEqual(actual, expected)
    }
}
