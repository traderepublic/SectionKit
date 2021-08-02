@testable import SectionKit
import XCTest

internal class ErrorTests: XCTestCase {
    internal func testDescriptionOfNotImplemented() {
        XCTAssertEqual(
            Error.notImplemented(function: "function()").description,
            "function() not implemented."
        )
    }

    internal func testDescriptionOfDuplicateSectionIds() {
        XCTAssertEqual(
            Error.duplicateSectionIds(["1", "2"]).description,
            "The list of sections contains two or more sections with the same id. Affected section id(s): [AnyHashable(\"1\"), AnyHashable(\"2\")]"
        )
    }

    internal func testDescriptionOfMissingDataSource() {
        XCTAssertEqual(
            Error.missingDataSource(section: 1).description,
            "There is no datasource for section with index 1."
        )
    }

    internal func testDescriptionOfUnsupportedSupplementaryViewKind() {
        XCTAssertEqual(
            Error.unsupportedSupplementaryViewKind(elementKind: "invalid").description,
            "Unsupported supplementary view kind \"invalid\"."
        )
    }

    internal func testDescriptionOfInvalidIndexPath() {
        XCTAssertEqual(
            Error.invalidIndexPath(IndexPath(item: 1, section: 2)).description,
            "The given IndexPath [2, 1] is not valid (does not contain exactly 2 values)."
        )
    }

    internal func testDescriptionOfMoveIsNotInTheSameSection() {
        XCTAssertEqual(
            Error.moveIsNotInTheSameSection(sourceSection: 1, destinationSection: 2).description,
            "Move is not supported inside the same section (from 1 to 2)."
        )
    }

    internal func testDescriptionOfSectionAdapterIsNotSet() {
        XCTAssertEqual(
            Error.sectionAdapterIsNotSet.description,
            "The `sectionAdapter` is not set on the context."
        )
    }

    internal func testDescriptionOfAdapterDoesNotContainSectionController() {
        XCTAssertEqual(
            Error.adapterDoesNotContainSectionController.description,
            "The given controller is not child of this adapter."
        )
    }

    internal func testDescriptionOfDequeuedViewHasNotTheCorrectType() {
        class ExpectedCollectionReusableView: UICollectionReusableView { }
        class ActualCollectionReusableView: UICollectionReusableView { }
        XCTAssertEqual(
            Error.dequeuedViewHasNotTheCorrectType(expected: ExpectedCollectionReusableView.self, actual: ActualCollectionReusableView.self).description,
            "The dequeued view has not the correct type. Expected: ExpectedCollectionReusableView Actual: ActualCollectionReusableView"
        )
    }

    internal func testDescriptionOfSectionControllerModelTypeMismatch() {
        XCTAssertEqual(
            Error.sectionControllerModelTypeMismatch(expected: Int.self, actual: String.self).description,
            "The model that was given to the sectioncontroller has not the correct type. Expected: Int Actual: String"
        )
    }
}
