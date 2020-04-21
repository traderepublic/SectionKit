import UIKit

extension SectionAdapter: UICollectionViewDataSource {
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionControllers.count
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             numberOfItemsInSection section: Int) -> Int {
        guard section >= 0 && section < sectionControllers.count else {
            assertionFailure("Could not find the specified section")
            return 0
        }
        return sectionControllers[section].dataSource.numberOfItems
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard indexPath.section >= 0 && indexPath.section < sectionControllers.count else {
            assertionFailure("Could not find the specified section")
            return UICollectionViewCell()
        }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sectionControllers[indexPath.section].dataSource.cellForItem(at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             viewForSupplementaryElementOfKind elementKind: String,
                             at indexPath: IndexPath) -> UICollectionReusableView {
        guard indexPath.section >= 0 && indexPath.section < sectionControllers.count else {
            assertionFailure("Could not find the specified section")
            return UICollectionReusableView()
        }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        
        let sectionController = sectionControllers[indexPath.section]
        
        switch elementKind {
        case UICollectionView.elementKindSectionHeader:
            return sectionController.dataSource.headerView(at: sectionIndexPath)
        case UICollectionView.elementKindSectionFooter:
            return sectionController.dataSource.footerView(at: sectionIndexPath)
        default:
            assertionFailure("Unsupported supplementary view kind.")
            return UICollectionReusableView()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             canMoveItemAt indexPath: IndexPath) -> Bool {
        guard indexPath.section >= 0 && indexPath.section < sectionControllers.count else {
            assertionFailure("Could not find the specified section")
            return false
        }
        let sectionIndexPath = SectionIndexPath(externalRepresentation: indexPath,
                                                internalRepresentation: indexPath.item)
        return sectionControllers[indexPath.section].dataSource.canMoveItem(at: sectionIndexPath)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             moveItemAt sourceIndexPath: IndexPath,
                             to destinationIndexPath: IndexPath) {
        guard sourceIndexPath.section >= 0 && sourceIndexPath.section < sectionControllers.count else {
            assertionFailure("Could not find the specified section")
            return
        }
        guard allowReorderingBetweenDifferentSections || sourceIndexPath.section == destinationIndexPath.section else {
            return
        }
        let sourceSectionIndexPath = SectionIndexPath(externalRepresentation: sourceIndexPath,
                                                      internalRepresentation: sourceIndexPath.item)
        let destinationSectionIndexPath = SectionIndexPath(externalRepresentation: destinationIndexPath,
                                                           internalRepresentation: destinationIndexPath.item)
        sectionControllers[sourceIndexPath.section].dataSource.moveItem(at: sourceSectionIndexPath,
                                                                        to: destinationSectionIndexPath)
    }
    
    open func indexTitles(for collectionView: UICollectionView) -> [String]? {
        cachedIndexTitles = sectionControllers.flatMap { section in
            (section.dataSource.indexTitles ?? []).map { (sectionId: section.id, title: $0) }
        }
        return cachedIndexTitles.map(\.title)
    }
    
    open func collectionView(_ collectionView: UICollectionView,
                             indexPathForIndexTitle title: String,
                             at index: Int) -> IndexPath {
        for (sectionIndex, section) in sectionControllers.enumerated() {
            guard section.id == cachedIndexTitles[index].sectionControllerId else { continue }
            let index = section.dataSource.index(for: title)
            return IndexPath(item: index, section: sectionIndex)
        }
        assertionFailure("The corresponding section wasn't found, it seems the id changed.")
        return IndexPath(item: 0, section: 0)
    }
}

