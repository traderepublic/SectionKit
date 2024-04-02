import UIKit

@available(iOS 13.0, *)
extension NSCollectionLayoutSection {
    static let empty: NSCollectionLayoutSection = {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .absolute(0),
            heightDimension: .absolute(0)
        )
        return NSCollectionLayoutSection(
            group: .vertical(
                layoutSize: layoutSize,
                subitem: .init(layoutSize: layoutSize),
                count: 1
            )
        )
    }()
}
