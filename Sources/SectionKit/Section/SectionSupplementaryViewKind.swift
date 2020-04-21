import UIKit

public enum SectionSupplementaryViewKind: Equatable {
    case header
    case footer
    
    init?(collectionViewElementKind: String) {
        switch collectionViewElementKind {
        case UICollectionView.elementKindSectionHeader:
            self = .header
        case UICollectionView.elementKindSectionFooter:
            self = .footer
        default:
            return nil
        }
    }
    
    var collectionViewElementKind: String {
        switch self {
        case .header: return UICollectionView.elementKindSectionHeader
        case .footer: return UICollectionView.elementKindSectionFooter
        }
    }
}

