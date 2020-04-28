import UIKit

open class SingleItemSectionController<CellType: UICollectionViewCell>: BaseSectionController {
    
    // MARK: - Properties
    
    private let _id: String
    override open var id: String { _id }
    
    open var configure: ((CollectionContext, CellType, SectionIndexPath) -> ())?
    
    open var size: ((CollectionContext, SectionIndexPath, UICollectionViewLayout) -> CGSize)?
    
    open var didSelect: ((CollectionContext, SectionIndexPath) -> ())?
    
    // MARK: - Init
    
    init(id: String) {
        self._id = id
        super.init()
    }
    
    override public convenience init() {
        self.init(id: UUID().uuidString)
    }
    
    // MARK: - SectionDataSource
    
    override open var numberOfItems: Int {
        return 1
    }
    
    override open func cellForItem(at indexPath: SectionIndexPath) -> UICollectionViewCell {
        let cell = context!.dequeueReusableCell(CellType.self, for: indexPath.externalRepresentation)
        configure?(context!, cell, indexPath)
        return cell
    }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        return size?(context!, indexPath, layout)
            ?? super.sizeForItem(at: indexPath, using: layout)
    }
    
    // MARK: - SectionDelegate
    
    override open func shouldHighlightItem(at indexPath: SectionIndexPath) -> Bool {
        return didSelect != nil
    }
    
    override open func shouldSelectItem(at indexPath: SectionIndexPath) -> Bool {
        return didSelect != nil
    }
    
    override open func didSelectItem(at indexPath: SectionIndexPath) {
        didSelect?(context!, indexPath)
    }
}
