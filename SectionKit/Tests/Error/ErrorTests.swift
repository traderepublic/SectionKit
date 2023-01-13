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
            "A move between different sections is not supported (from 1 to 2)."
        )
    }

    internal func testDescriptionOfAdapterIsNotSetOnContext() {
        XCTAssertEqual(
            Error.adapterIsNotSetOnContext.description,
            "The `adapter` is not set on the context."
        )
    }

    internal func testDescriptionOfAdapterDoesNotContainSectionController() {
        XCTAssertEqual(
            Error.adapterDoesNotContainSectionController.description,
            "The given sectioncontroller is not a child of this adapter."
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

    internal func testEquality() {
        XCTAssertEqual(
            Error.notImplemented(function: "test"),
            .notImplemented(function: "test")
        )
        XCTAssertEqual(
            Error.duplicateSectionIds([1, 2, 3]),
            .duplicateSectionIds([1, 2, 3])
        )
        XCTAssertEqual(
            Error.missingDataSource(section: 1),
            .missingDataSource(section: 1)
        )
        XCTAssertEqual(
            Error.unsupportedSupplementaryViewKind(elementKind: "test"),
            .unsupportedSupplementaryViewKind(elementKind: "test")
        )
        XCTAssertEqual(
            Error.invalidIndexPath(IndexPath(row: 1, section: 2)),
            .invalidIndexPath(IndexPath(row: 1, section: 2))
        )
        XCTAssertEqual(
            Error.moveIsNotInTheSameSection(sourceSection: 1, destinationSection: 2),
            .moveIsNotInTheSameSection(sourceSection: 1, destinationSection: 2)
        )
        XCTAssertEqual(
            Error.adapterIsNotSetOnContext,
            .adapterIsNotSetOnContext
        )
        XCTAssertEqual(
            Error.adapterDoesNotContainSectionController,
            .adapterDoesNotContainSectionController
        )
        XCTAssertEqual(
            Error.dequeuedViewHasNotTheCorrectType(
                expected: MockCollectionReusableView.self,
                actual: UICollectionReusableView.self
            ),
            .dequeuedViewHasNotTheCorrectType(
                expected: MockCollectionReusableView.self,
                actual: UICollectionReusableView.self
            )
        )
        XCTAssertEqual(
            Error.sectionControllerModelTypeMismatch(expected: Int.self, actual: String.self),
            .sectionControllerModelTypeMismatch(expected: Int.self, actual: String.self)
        )
    }

    internal func testNotEqualsWhenAssociatedValueIsDifferent() {
        XCTAssertNotEqual(
            Error.notImplemented(function: "test1"),
            .notImplemented(function: "test2")
        )
        XCTAssertNotEqual(
            Error.duplicateSectionIds([1, 2, 3]),
            .duplicateSectionIds([4, 5, 6])
        )
        XCTAssertNotEqual(
            Error.missingDataSource(section: 1),
            .missingDataSource(section: 2)
        )
        XCTAssertNotEqual(
            Error.unsupportedSupplementaryViewKind(elementKind: "test1"),
            .unsupportedSupplementaryViewKind(elementKind: "test2")
        )
        XCTAssertNotEqual(
            Error.invalidIndexPath(IndexPath(row: 1, section: 2)),
            .invalidIndexPath(IndexPath(row: 3, section: 4))
        )
        XCTAssertNotEqual(
            Error.moveIsNotInTheSameSection(sourceSection: 1, destinationSection: 2),
            .moveIsNotInTheSameSection(sourceSection: 3, destinationSection: 4)
        )
        XCTAssertNotEqual(
            Error.dequeuedViewHasNotTheCorrectType(
                expected: MockCollectionReusableView.self,
                actual: UICollectionReusableView.self
            ),
            .dequeuedViewHasNotTheCorrectType(
                expected: UICollectionReusableView.self,
                actual: MockCollectionReusableView.self
            )
        )
        XCTAssertNotEqual(
            Error.sectionControllerModelTypeMismatch(expected: Int.self, actual: String.self),
            .sectionControllerModelTypeMismatch(expected: Float.self, actual: Double.self)
        )
    }

    internal func testNotEqualsWhenDifferentCase() {
        XCTAssertNotEqual(
            Error.notImplemented(function: "test"),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.duplicateSectionIds([1, 2, 3]),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.missingDataSource(section: 1),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.unsupportedSupplementaryViewKind(elementKind: "test"),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.invalidIndexPath(IndexPath(row: 1, section: 2)),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.moveIsNotInTheSameSection(sourceSection: 1, destinationSection: 2),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.adapterIsNotSetOnContext,
            .adapterDoesNotContainSectionController
        )
        XCTAssertNotEqual(
            Error.adapterDoesNotContainSectionController,
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.dequeuedViewHasNotTheCorrectType(
                expected: MockCollectionReusableView.self,
                actual: UICollectionReusableView.self
            ),
            .adapterIsNotSetOnContext
        )
        XCTAssertNotEqual(
            Error.sectionControllerModelTypeMismatch(expected: Int.self, actual: String.self),
            .adapterIsNotSetOnContext
        )
    }

    private final class MockCollectionReusableView: UICollectionReusableView { }
}
