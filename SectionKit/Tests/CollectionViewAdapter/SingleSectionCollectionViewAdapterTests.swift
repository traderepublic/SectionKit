@testable import SectionKit
import XCTest

internal final class SingleSectionCollectionViewAdapterTests: XCTestCase {
    internal func testSectionControllerIsReused() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        let adapter = SingleSectionCollectionViewAdapter(viewController: nil, collectionView: collectionView)

        let firstSection = Section(id: "", model: "", controller: BaseSectionController())
        let secondSection = Section(id: "", model: "", controller: {
            XCTFail("Second section controller should not be initialized")
            return BaseSectionController()
        })

        adapter.section = firstSection
        adapter.section = secondSection
        XCTAssert(adapter.section?.controller === firstSection.controller)
    }
}
