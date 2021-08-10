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
    @inlinable
    public func informational(
        error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        on(error: error(), severity: .informational, file: file, line: line)
    }

    @inlinable
    public func nonCritical(
        error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        on(error: error(), severity: .nonCritical, file: file, line: line)
    }

    @inlinable
    public func critical(
        error: @autoclosure () -> Error,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        on(error: error(), severity: .critical, file: file, line: line)
    }
}

/**
 This error handler calls `fatalError` for `critical` errors, `assertionFailure` for `nonCritical` errors and
 ignores `informational` errors.
 */
public struct ErrorHandler: ErrorHandling {
    private let verbose: Bool

    /**
     Initialise an instance of `ErrorHandler`.

     This error handler calls `fatalError` for `critical` errors, `assertionFailure` for `nonCritical` errors and
     ignores `informational` errors.

     - Parameter verbose: If `informational` errors should be printed to the console.
     */
    public init(verbose: Bool = false) {
        self.verbose = verbose
    }

    public func on(error: @autoclosure () -> Error, severity: Error.Severity, file: StaticString, line: UInt) {
        switch severity {
        case .informational:
            if verbose {
                print("\(file):\(line): \(severity.rawValue.capitalized) error: \(error().description)")
            }

        case .nonCritical:
            assertionFailure(error().description, file: file, line: line)

        case .critical:
            fatalError(error().description, file: file, line: line)
        }
    }
}
