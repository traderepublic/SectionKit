import Foundation

/// A handler to intercept errors.
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
        /// Errors with this severity may inform users about potential future deprecations.
        case informational

        /// Errors with this severity are non-fatal and can be recovered from.
        case nonCritical

        /// Errors with this severity are fatal and can't be recovered from.
        case critical
    }
}

extension ErrorHandling {
    public func callAsFunction(
        error: @autoclosure () -> Error,
        severity: Error.Severity = .nonCritical,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        on(error: error(), severity: severity, file: file, line: line)
    }
}

/// This error handler calls `fatalError` for `critical` errors, `assertionFailure` for `nonCritical` errors and ignores `informational` errors.
public struct ErrorHandler: ErrorHandling {
    public init() { }

    public func on(error: @autoclosure () -> Error, severity: Error.Severity, file: StaticString, line: UInt) {
        switch severity {
        case .informational:
            break

        case .nonCritical:
            assertionFailure(error().description, file: file, line: line)

        case .critical:
            fatalError(error().description, file: file, line: line)
        }
    }
}
