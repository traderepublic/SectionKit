@testable import SectionKit
import UIKit
import XCTest

internal final class MockCollectionViewContext: CollectionViewContext {
    internal var viewController: UIViewController?

    internal var collectionView: UICollectionView

    internal var errorHandler: ErrorHandling

    internal init(
        viewController: UIViewController? = nil,
        collectionView: UICollectionView,
        errorHandler: ErrorHandling
    ) {
        self.viewController = viewController
        self.collectionView = collectionView
        self.errorHandler = errorHandler
    }

    internal func apply<T>(update: CollectionViewSectionUpdate<T>) { }

    internal func apply<T>(update: CollectionViewUpdate<T>) { }

    internal func sectionControllerWithAdjustedIndexPath(
        for indexPath: IndexPath
    ) -> (SectionController?, SectionIndexPath)? {
        nil
    }

    // MARK: - dequeueReusableCell

    internal typealias DequeueReusableCellBlock = (UICollectionViewCell.Type, IndexPath) -> UICollectionViewCell

    internal lazy var _dequeueReusableCell: DequeueReusableCellBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableCell<Cell>(
        _ cellType: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell where Cell : UICollectionViewCell {
        _dequeueReusableCell(cellType, indexPath) as! Cell
    }

    // MARK: - dequeueReusableHeaderView

    internal typealias DequeueReusableHeaderViewBlock = (UICollectionReusableView.Type, IndexPath) -> UICollectionReusableView

    internal lazy var _dequeueReusableHeaderView: DequeueReusableHeaderViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableHeaderView<SupplementaryView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView where SupplementaryView : UICollectionReusableView {
        _dequeueReusableHeaderView(viewType, indexPath) as! SupplementaryView
    }

    // MARK: - dequeueReusableFooterView

    internal typealias DequeueReusableFooterViewBlock = (UICollectionReusableView.Type, IndexPath) -> UICollectionReusableView

    internal lazy var _dequeueReusableFooterView: DequeueReusableFooterViewBlock = { _, _ in
        XCTFail("not implemented")
        return UICollectionViewCell()
    }

    internal func dequeueReusableFooterView<SupplementaryView>(
        _ viewType: SupplementaryView.Type,
        for indexPath: IndexPath
    ) -> SupplementaryView where SupplementaryView : UICollectionReusableView {
        _dequeueReusableFooterView(viewType, indexPath) as! SupplementaryView
    }

    // MARK: - Index

    internal typealias IndexBlock = (SectionController) -> Int?

    internal lazy var _index: IndexBlock = { _ in
        XCTFail("not implemented")
        return nil
    }

    internal func index(of controller: SectionController) -> Int? {
        _index(controller)
    }
}
