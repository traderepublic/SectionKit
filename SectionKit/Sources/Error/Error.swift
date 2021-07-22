import Foundation

/// An enumeration of all SectionKit errors.
public enum Error: Swift.Error {
    /// The function hasn't been implemented.
    case notImplemented(function: StaticString = #function)

    /// The list of sections contains two or more sections with the same id.
    /// This is not supported and would result in undefined behaviour.
    case duplicateSectionIds

    /// There is no datasource for section with given index.
    case missingDataSource(section: Int)

    /// The given supplementary view kind is not supported.
    case unsupportedSupplementaryViewKind

    /// The given `IndexPath` is not valid (does not contain exactly 2 values).
    case invalidIndexPath(IndexPath)

    /// Move is not supported inside the same section.
    case moveIsNotInTheSameSection
}

extension Error: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .notImplemented(function):
            return "\(function) not implemented."

        case .duplicateSectionIds:
            return "The list of sections contains two or more sections with the same id."

        case let .missingDataSource(section: section):
            return "There is no datasource for section with index \(section)."

        case .unsupportedSupplementaryViewKind:
            return "Unsupported supplementary view kind."

        case let .invalidIndexPath(indexPath):
            return "The given IndexPath \(indexPath) is not valid (does not contain exactly 2 values)."

        case .moveIsNotInTheSameSection:
            return "Move is not supported inside the same section."
        }
    }
}
