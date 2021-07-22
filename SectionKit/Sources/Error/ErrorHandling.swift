import Foundation

/// A handler to intercept errors.
public protocol ErrorHandling {
    /**
     A function that is called when an error is encountered.
     - Parameter error: The error that is encountered.
     */
    func on(error: Error)
}

/// This error handler calls `assertionFailure` for every error that is encountered.
public struct AssertionFailureErrorHandler: ErrorHandling {
    public init() { }

    @inlinable
    public func on(error: Error) {
        assertionFailure(error.description)
    }
}
