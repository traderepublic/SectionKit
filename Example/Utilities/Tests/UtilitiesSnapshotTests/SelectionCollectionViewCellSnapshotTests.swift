import SnapshotTesting
@testable import Utilities
import XCTest

final class SelectionCollectionViewCellSnapshotTests: XCTestCase {
    func testDefault() {
        let cell = SelectionCollectionViewCell()
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))
    }
    
    func testBackgroundColor() {
        let cell = SelectionCollectionViewCell()
        cell.backgroundColor = .red
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))
    }

    func testSelectedBackgroundColorWithoutSelection() {
        let cell = SelectionCollectionViewCell()
        cell.selectedBackgroundColor = .red
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))
    }

    func testSelectedBackgroundColorWithSelection() {
        let cell = SelectionCollectionViewCell()
        cell.selectedBackgroundColor = .blue
        cell.isSelected = true
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))
    }

    func testCornerRadiusAffectsBackgroundColor() {
        let cell = SelectionCollectionViewCell()
        cell.cornerRadius = 8
        cell.backgroundColor = .red
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))

    }

    func testCornerRadiusAffectsSelectedBackgroundColor() {
        let cell = SelectionCollectionViewCell()
        cell.cornerRadius = 8
        cell.selectedBackgroundColor = .red
        cell.isSelected = true
        assertSnapshot(matching: cell, as: .image(size: CGSize(width: 50, height: 50)))
    }
}
