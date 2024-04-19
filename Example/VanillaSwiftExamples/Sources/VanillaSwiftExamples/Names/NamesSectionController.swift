import SectionKit
import UIKit

final class NamesSectionController: ListSectionController<
    NamesSectionViewModelType,
    String
> {
    override var layoutProvider: SectionLayoutProvider {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(50)
        )

        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let layout = NSCollectionLayoutSection(
            group: .vertical(
                layoutSize: layoutSize,
                subitem: item,
                count: 1
            )
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true

        // Hide the section header if it's collapsed
        if !model.isCollapsed {
            layout.boundarySupplementaryItems = [header]
        } else {
            layout.boundarySupplementaryItems = []
        }
        return .compositionalLayout(
            .init(layoutSection: { _ in layout })
        )
    }

    override func items(for model: NamesSectionViewModelType) -> [String] {
        model.isCollapsed ? [] : model.names
    }

    override func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let cell: NameCell = context.dequeueReusableCell(for: indexPath)
        cell.set(name: items[indexPath])
        return cell
    }

    override func didSelectItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) {
        model.select(name: items[indexPath])
        context.collectionView.deselectItem(at: indexPath.indexInCollectionView, animated: true)
    }

    // MARK: - Header

    override func headerView(
        at indexPath: SectionIndexPath,
        in context: any CollectionViewContext
    ) -> UICollectionReusableView {
        let header: NameSectionHeaderView = context.dequeueReusableHeaderView(for: indexPath)
        header.set(title: model.sectionId) { [weak self] in
            guard let self else { return }
            self.model.pressCollapse()
            // Reload the items
            self.items = items(for: self.model)
        }
        return header
    }
}
