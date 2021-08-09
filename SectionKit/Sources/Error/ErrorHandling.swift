import Foundation

/// A handler to intercept errors or warnings.
public protocol ErrorHandling {
    /**
     A function that is called when an error is encountered.

     - Parameter error: The error that is encountered.

     - Parameter file: The file name where the error occurred.

     - Parameter line: The line number where the error occurred in the file.
     */
    func on(error: @autoclosure () -> Error, severity: Error.Severity, file: StaticString, line: UInt)
}

extension Error {
    /// The severity of an error.
    public enum Severity: String, Hashable {
        case warning
        case error
    }
}

extension ErrorHandling {
    public func callAsFunction(
        error: @autoclosure () -> Error,
        severity: Error.Severity = .error,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        on(error: error(), severity: severity, file: file, line: line)
    }
}

/// This error handler calls `assertionFailure` for every error that is encountered, warnings are ignored.
public struct AssertionFailureErrorHandler: ErrorHandling {
    public init() { }

    @inlinable
    public func on(error: @autoclosure () -> Error, severity: Error.Severity, file: StaticString, line: UInt) {
        guard case .error = severity else { return }
        assertionFailure(error().description, file: file, line: line)
    }
}
