import SectionKit
import UIKit

final class ActivitiesSectionController: ListSectionController<[String], String> {
    override var layoutProvider: SectionLayoutProvider {
        .compositionalLayout(
            .init(
                layoutSectionProvider: { _ in
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
                    return layout
                }
            )
        )
    }

    override func items(for model: [String]) -> [String] {
        model
    }

    override func cellForItem(
        at indexPath: SectionIndexPath,
        in context: CollectionViewContext
    ) -> UICollectionViewCell {
        let item = items[indexPath]
        let cell: UICollectionViewListCell = context.dequeueReusableCell(for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = item
        cell.contentConfiguration = contentConfiguration
        return cell
    }
}
