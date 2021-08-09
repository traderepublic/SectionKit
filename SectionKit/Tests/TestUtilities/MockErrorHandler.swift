import SectionKit
import XCTest

internal struct MockErrorHandler: ErrorHandling {
    internal var onError: (Error, Error.Severity) -> Void

    init(onError: @escaping (Error, Error.Severity) -> Void = { error, severity in
        XCTFail("ErrorHandler received \(severity): \(error.localizedDescription)")
    }) {
        self.onError = onError
    }

    internal func on(error: @autoclosure () -> Error, severity: Error.Severity, file: StaticString, line: UInt) {
        onError(error(), severity)
    }
}
