import XCTest
@testable import SectionKit

final class StackTests: XCTestCase {
    static var allTests = [
        ("testPush", testPush),
        ("testPeek", testPeek),
        ("testPop", testPop),
        ("testIsEmpty", testIsEmpty),
        ("testDescription", testDescription),
    ]

    func testPush() {
        var input: Stack<Int> = []
        var output = input.push(1)
        var expected = Stack<Int>([1])
        XCTAssertEqual(output, expected)
        output.push(2)
        expected = Stack<Int>([1,2])
        XCTAssertEqual(output, expected)
    }

    func testPeek() {
        var input: Stack<Int> = [1]
        var output = input.peek()
        var expected = 1
        XCTAssertEqual(output, expected)
        input.push(2)
        output = input.peek()
        expected = 2
        XCTAssertEqual(output, expected)
    }

    func testPop() {
        var input: Stack<Int> = [1, 2]
        var output = input.pop()
        var expected = 2
        XCTAssertEqual(output, expected)
        output = input.pop()
        expected = 1
        XCTAssertEqual(output, expected)
    }

    func testIsEmpty() {
        var input: Stack<Int> = [1]
        var output = input.isEmpty
        var expected = false
        XCTAssertEqual(output, expected)
        input.pop()
        output = input.isEmpty
        expected = true
        XCTAssertEqual(output, expected)
    }

    func testDescription() {
        var input: Stack<Int> = [1]
        var output = input.description
        var expected = "[1]"
        XCTAssertEqual(output, expected)
        input.pop()
        output = input.description
        expected = "[]"
        XCTAssertEqual(output, expected)
    }
}
