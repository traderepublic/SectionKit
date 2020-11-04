import DifferenceKit
import Foundation
import SectionKit

/**
 A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

 This `SectionController` is typically used when there are multiple semantically similar items
 of a model to be displayed and the list of items may dynamically change.

 - Note: Compared to `DiffingListSectionController` this doesn't have a `Differentiable` constraint on the generic
 `Item` type, instead it requires closures to get diffing information for an item.
 */
open class ManualDiffingListSectionController<
    Model,
    Item,
    ItemId: Hashable
>: ListSectionController<Model, Item> {
    private let itemId: (Item) -> ItemId
    private let itemContentIsEqual: (Item, Item) -> Bool

    /**
     Initialize an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemId: A closure that returns the identifier for a given item.

     - Parameter itemContentIsEqual: A closure that checks two items for equality.
     */
    public init(model: Model, itemId: @escaping (Item) -> ItemId, itemContentIsEqual: @escaping (Item, Item) -> Bool) {
        self.itemId = itemId
        self.itemContentIsEqual = itemContentIsEqual
        super.init(model: model)
    }

    override open func calculateUpdate(from oldData: [Item],
                                       to newData: [Item]) -> CollectionViewSectionUpdate<[Item]>? {
        let changeSet = StagedChangeset(
            source: oldData.map { DifferentiableBox(value: $0, id: itemId, isContentEqual: itemContentIsEqual) },
            target: newData.map { DifferentiableBox(value: $0, id: itemId, isContentEqual: itemContentIsEqual) }
        )
        return CollectionViewSectionUpdate(controller: self,
                                           batchOperations: changeSet.mapData(\.value).map(\.sectionBatchOperation),
                                           setData: { [weak self] in self?.collectionViewItems = $0 },
                                           shouldReload: { $0.changes.count > 100 })
    }
}

extension ManualDiffingListSectionController where Item: Equatable {
    /**
     Initialize an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemId: A closure that returns the identifier for a given item.
     */
    public convenience init(model: Model, itemId: @escaping (Item) -> ItemId) {
        self.init(model: model, itemId: itemId, itemContentIsEqual: ==)
    }
}

@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension ManualDiffingListSectionController where Item: Identifiable, Item.ID == ItemId {
    /**
     Initialize an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemContentIsEqual: A closure that checks two items for equality.
     */
    public convenience init(model: Model, itemContentIsEqual: @escaping (Item, Item) -> Bool) {
        self.init(model: model, itemId: \.id, itemContentIsEqual: itemContentIsEqual)
    }
}

// NOTE: the following unfortunately doesn't compile since declaring `init(model: Model)` would require
// to override the parent initialiser
//@available(OSX 10.15, iOS 13, tvOS 13, watchOS 6, *)
//extension ManualDiffingListSectionController where Item: Identifiable & Equatable, Item.ID == ItemId {
//    /**
//     Initialize an instance of `ManualDiffingListSectionController`.
//
//     - Parameter model: The model of this `SectionController`.
//     */
//    public convenience init(model: Model) {
//        self.init(model: model, itemId: \.id, itemContentIsEqual: ==)
//    }
//}
