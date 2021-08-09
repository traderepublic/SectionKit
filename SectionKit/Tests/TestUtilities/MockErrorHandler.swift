import SectionKit
import XCTest

internal struct MockErrorHandler: ErrorHandling {
    internal var onError: (Error) -> Void

    init(onError: @escaping (Error) -> Void = { error in
        XCTFail("ErrorHandler received error: \(error.localizedDescription)")
    }) {
        self.onError = onError
    }

    internal func on(error: @autoclosure () -> Error, file: StaticString, line: UInt) {
        onError(error())
    }
}
