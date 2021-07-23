import UIKit

extension ListCollectionViewAdapter: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        guard let dataSource = dataSource(at: section) else {
            context.errorHandler(error: .missingDataSource(section: section))
            return 0
        }
        return dataSource.numberOfItems(in: context)
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard indexPath.isValid else {
            context.errorHandler(error: .invalidIndexPath(indexPath))
            return UICollectionViewCell()
        }
        guard let dataSource = dataSource(at: indexPath) else {
            context.errorHandler(error: .missingDataSource(section: indexPath.section))
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
        guard indexPath.isValid else {
            context.errorHandler(error: .invalidIndexPath(indexPath))
            return UICollectionReusableView()
        }
        guard let dataSource = dataSource(at: indexPath) else {
            context.errorHandler(error: .missingDataSource(section: indexPath.section))
            return UICollectionReusableView()
        }
        let sectionIndexPath = SectionIndexPath(indexPath)
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return dataSource.headerView(at: sectionIndexPath, in: context)

        case UICollectionView.elementKindSectionFooter:
            return dataSource.footerView(at: sectionIndexPath, in: context)

        default:
            context.errorHandler(error: .unsupportedSupplementaryViewKind(elementKind: elementKind))
            return UICollectionReusableView()
        }
    }

    open func collectionView(
        _ collectionView: UICollectionView,
        canMoveItemAt indexPath: IndexPath
    ) -> Bool {
        guard indexPath.isValid else {
            context.errorHandler(error: .invalidIndexPath(indexPath))
            return false
        }
        guard let dataSource = dataSource(at: indexPath) else {
            context.errorHandler(error: .missingDataSource(section: indexPath.section))
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
        guard sourceIndexPath.isValid else {
            context.errorHandler(error: .invalidIndexPath(sourceIndexPath))
            return
        }
        guard destinationIndexPath.isValid else {
            context.errorHandler(error: .invalidIndexPath(destinationIndexPath))
            return
        }
        guard let dataSource = dataSource(at: sourceIndexPath) else {
            context.errorHandler(error: .missingDataSource(section: sourceIndexPath.section))
            return
        }
        guard sourceIndexPath.section == destinationIndexPath.section else {
            context.errorHandler(
                error: .moveIsNotInTheSameSection(
                    sourceSection: sourceIndexPath.section,
                    destinationSection: destinationIndexPath.section
                )
            )
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
        context.errorHandler(error: .notImplemented())
        return IndexPath(item: 0, section: 0)
    }
}
