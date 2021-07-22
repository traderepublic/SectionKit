import Foundation

/// A handler to intercept errors.
public protocol ErrorHandling {
    /**
     A function that is called when an error is encountered.

     - Parameter error: The error that is encountered.

     - Parameter file: The file name where the error occurred.

     - Parameter line: The line number where the error occurred in the file.
     */
    func on(error: @autoclosure () -> Error, file: StaticString, line: UInt)
}

extension ErrorHandling {
    public func callAsFunction(error: @autoclosure () -> Error, file: StaticString = #file, line: UInt = #line) {
        on(error: error(), file: file, line: line)
    }
}

/// This error handler calls `assertionFailure` for every error that is encountered.
public struct AssertionFailureErrorHandler: ErrorHandling {
    public init() { }

    @inlinable
    public func on(error: @autoclosure () -> Error, file: StaticString, line: UInt) {
        assertionFailure(error().description, file: file, line: line)
    }
}
