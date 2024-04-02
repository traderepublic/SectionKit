@testable import SectionKit
import XCTest

final class BaseCompositionalLayoutSectionControllerTests: XCTestCase {
    final class TestLayoutEnvironment: NSObject, NSCollectionLayoutEnvironment {
        final class TestLayoutContainer: NSObject, NSCollectionLayoutContainer {
            let contentSize: CGSize = .zero
            let effectiveContentSize: CGSize = .zero
            let contentInsets: NSDirectionalEdgeInsets = .zero
            let effectiveContentInsets: NSDirectionalEdgeInsets = .zero
        }
        let container: NSCollectionLayoutContainer = TestLayoutContainer()
        let traitCollection: UITraitCollection = .current
    }

    @MainActor
    func test_layout_isEmpty() {
        let sut = BaseCompositionalLayoutSectionController()
        let layoutSection = sut.layoutSection(
            layoutEnvironment: TestLayoutEnvironment()
        )
        XCTAssertEqual(layoutSection, .empty)
    }
}
