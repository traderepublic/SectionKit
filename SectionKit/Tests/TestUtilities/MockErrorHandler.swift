import SectionKit

internal struct MockErrorHandler: ErrorHandling {
    internal var onError: (Error) -> Void

    internal func on(error: @autoclosure () -> Error, file: StaticString, line: UInt) {
        onError(error())
    }
}
