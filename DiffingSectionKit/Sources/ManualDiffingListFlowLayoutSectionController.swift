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
@MainActor
open class ManualDiffingListFlowLayoutSectionController<
    Model,
    Item
>: ListFlowLaoutSectionController<Model, Item> {
    private let itemId: @MainActor (Item) -> AnyHashable
    private let itemContentIsEqual: @MainActor (Item, Item) -> Bool

    /**
     Initialise an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemId: A closure that returns the identifier for a given item.

     - Parameter itemContentIsEqual: A closure that checks two items for equality.
     */
    public init<ItemId: Hashable>(
        model: Model,
        itemId: @escaping @MainActor (Item) -> ItemId,
        itemContentIsEqual: @escaping @MainActor (Item, Item) -> Bool
    ) {
        self.itemId = { itemId($0) }
        self.itemContentIsEqual = itemContentIsEqual
        super.init(model: model)
    }

    override open func calculateUpdate(
        from oldData: [Item],
        to newData: [Item]
    ) -> CollectionViewSectionUpdate<[Item]>? {
        let changeSet = StagedChangeset(
            source: oldData.map { DifferentiableBox(value: $0, id: itemId, isContentEqual: itemContentIsEqual) },
            target: newData.map { DifferentiableBox(value: $0, id: itemId, isContentEqual: itemContentIsEqual) }
        )
        return CollectionViewSectionUpdate(
            controller: self,
            batchOperations: changeSet.mapData(\.value).map(\.sectionBatchOperation),
            setData: { self.collectionViewItems = $0 },
            shouldReload: { $0.count > 100 }
        )
    }
}

extension ManualDiffingListFlowLayoutSectionController where Item: Equatable {
    /**
     Initialise an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemId: A closure that returns the identifier for a given item.
     */
    public convenience init<ItemId: Hashable>(model: Model, itemId: @escaping @MainActor (Item) -> ItemId) {
        self.init(model: model, itemId: itemId, itemContentIsEqual: ==)
    }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension ManualDiffingListFlowLayoutSectionController where Item: Identifiable {
    /**
     Initialise an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemContentIsEqual: A closure that checks two items for equality.
     */
    public convenience init(model: Model, itemContentIsEqual: @escaping @MainActor (Item, Item) -> Bool) {
        self.init(model: model, itemId: \.id, itemContentIsEqual: itemContentIsEqual)
    }
}

/*
 Due to the compiler emitting an error it is only possible to declare default values for the parameters,
 but not omit the parameters altogether (i.e. `init(model:)`). By using default values,
 we can still call the init without specifying the parameters, but since the init is similar to
 the base init (apart from the default values), we have to specify `@_disfavoredOverload` so it doesn't call itself.
 */
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension ManualDiffingListFlowLayoutSectionController where Item: Identifiable & Equatable {
    /**
     Initialise an instance of `ManualDiffingListSectionController`.

     - Parameter model: The model of this `SectionController`.

     - Parameter itemId: A closure that returns the identifier for a given item.

     - Parameter itemContentIsEqual: A closure that checks two items for equality.
     */
    @_disfavoredOverload
    public convenience init(
        model: Model,
        itemId: @escaping @MainActor (Item) -> Item.ID = { $0.id },
        itemContentIsEqual: @escaping @MainActor (Item, Item) -> Bool = { $0 == $1 }
    ) {
        self.init(model: model, itemId: itemId, itemContentIsEqual: itemContentIsEqual)
    }
}

@available(
    *,
     deprecated,
     renamed: "ManualDiffingListFlowLayoutSectionController",
     message: "It has been renamed to ManualDiffingListFlowLayoutSectionController"
)

public typealias ManualDiffingListSectionController = ManualDiffingListFlowLayoutSectionController
