import UIKit

open class SingleItemSectionController: BaseSectionController {
    
    // MARK: - Properties
    
    private let _id: String
    override open var id: String { _id }
    
    open var cellProvider: ((CollectionContext, SectionIndexPath) -> UICollectionViewCell)?
    
    open var sizeProvider: ((CollectionContext, SectionIndexPath, UICollectionViewLayout) -> CGSize)?
    
    open var didSelect: ((CollectionContext, SectionIndexPath) -> ())?
    
    // MARK: - Init
    
    public init(id: String) {
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
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        guard let cellProvider = cellProvider else {
            assertionFailure("Did not set `cellProvider` before calling \(#function)")
            return UICollectionViewCell()
        }
        return cellProvider(context, indexPath)
    }
    
    // MARK: - SectionFlowDelegate
    
    override open func sizeForItem(at indexPath: SectionIndexPath,
                                   using layout: UICollectionViewLayout) -> CGSize {
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        return sizeProvider?(context, indexPath, layout)
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
        guard let context = context else {
            preconditionFailure("Did not set `context` before calling \(#function)")
        }
        didSelect?(context, indexPath)
    }
}
