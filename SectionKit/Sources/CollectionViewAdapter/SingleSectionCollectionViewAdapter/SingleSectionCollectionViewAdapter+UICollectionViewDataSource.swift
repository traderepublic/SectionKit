import UIKit

extension SingleSectionCollectionViewAdapter: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        section != nil ? 1 : 0
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let dataSource = dataSource(at: section) else {
            return 0
        }
        return dataSource.numberOfItems(in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let dataSource = dataSource(at: indexPath) else {
            return UICollectionViewCell()
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dataSource.cellForItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind elementKind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        guard let dataSource = dataSource(at: indexPath) else {
            return UICollectionReusableView()
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return dataSource.headerView(at: sectionIndexPath, in: context)

        case UICollectionView.elementKindSectionFooter:
            return dataSource.footerView(at: sectionIndexPath, in: context)

        default:
            assertionFailure("Unsupported supplementary view kind.")
            return UICollectionReusableView()
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        canMoveItemAt indexPath: IndexPath
    ) -> Bool {
        guard let dataSource = dataSource(at: indexPath) else {
            return false
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        return dataSource.canMoveItem(at: sectionIndexPath, in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        moveItemAt sourceIndexPath: IndexPath,
        to destinationIndexPath: IndexPath
    ) {
        guard let dataSource = dataSource(at: sourceIndexPath) else {
            return
        }
        guard sourceIndexPath.isValid && destinationIndexPath.isValid else {
            return
        }
        guard sourceIndexPath.section == destinationIndexPath.section else {
            return
        }
        let sourceSectionIndexPath = SectionIndexPath(sourceIndexPath)
        let destinationSectionIndexPath = SectionIndexPath(destinationIndexPath)
        dataSource.moveItem(at: sourceSectionIndexPath, to: destinationSectionIndexPath, in: context)
    }

    open func indexTitles(for collectionView: UICollectionView) -> [String]? { nil }

    open func collectionView(
        _ collectionView: UICollectionView,
        indexPathForIndexTitle title: String,
        at index: Int
    ) -> IndexPath {
        assertionFailure("collectionView(_:indexPathForIndexTitle:at:) not implemented")
        return IndexPath(item: 0, section: 0)
    }
}
