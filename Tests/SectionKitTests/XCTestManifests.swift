import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SectionKitTests.allTests),
        testCase(StackTests.allTests),
        testCase(SectionIndexPathTests.allTests),
        testCase(SectionBatchOperationTests.allTests)
    ]
}
#endif
