<p align="center">
    <a href="https://github.com/traderepublic/tr-sectionkit"><img src="Resources/SectionKit.svg" alt="SectionKit" width="66%"/></a>
    <br><br>
    <a href="https://github.com/traderepublic/tr-sectionkit/actions"><img src="https://github.com/traderepublic/tr-sectionkit/workflows/Unit%20Tests/badge.svg" alt="Unit Tests"/></a>
    <a href="#swift-package-manager"><img src="https://img.shields.io/badge/SwiftPM-compatible-orange.svg" alt="SwiftPM compatible"/></a>
    <a href="#carthage"><img src="https://img.shields.io/badge/Carthage-compatible-orange.svg" alt="Carthage compatible"/></a>
    <a href="https://github.com/traderepublic/tr-sectionkit/releases"><img src="https://img.shields.io/github/release/traderepublic/tr-sectionkit.svg" alt="Release"/></a>
</p>



By using **SectionKit** each section in a `UICollectionView` is implemented separately, so you can keep your classes small and maintainable.
Sections can be combined like building blocks and creating screens with otherwise complex datasources becomes manageable.

To see SectionKit in action please check out the [example project](Example).

#### Contents:

- [SectionKit @ Trade Republic](#sectionkit--trade-republic)
- [Inspiration](#inspiration)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Overview](#overview)

## SectionKit @ Trade Republic

At [Trade Republic](https://traderepublic.com) we are using SectionKit extensively. 
It powers most of our screens, with some of them containing up to 30 different types of sections.
By combining SectionKit with [ReactiveSwift](https://github.com/ReactiveCocoa/ReactiveSwift) and a reactive network protocol 
we are able to provide truly dynamic experiences.

## Inspiration

This library is inspired by [IGListKit](https://github.com/Instagram/IGListKit), but it is implemented in Swift and offers a type safe API through the use of generics. 
The entire API was designed to be as open as possible and makes it easy to implement a custom behaviour.
An example would be the API for calculating updates to the `UICollectionView`: By default, it will just reload without performing any animation, 
but subclasses in `DiffingSectionKit` override a corresponding function to provide rich diffs by using [DifferenceKit](https://github.com/ra1028/DifferenceKit).

## Installation

### Swift Package Manager

#### Automatically in Xcode:

- Click **File > Swift Packages > Add Package Dependency...**  
- Use the package URL `https://github.com/traderepublic/tr-sectionkit` to add SectionKit/DiffingSectionKit to your project.

#### Manually in your `Package.swift` file:

On the package:
```swift
dependencies: [
    .package(name: "SectionKit", url: "https://github.com/traderepublic/tr-sectionkit", from: "1.0")
]
```

On a target:
```swift
dependencies: [
    .product(name: "SectionKit", package: "SectionKit"),
    .product(name: "DiffingSectionKit", package: "SectionKit") // optionally, includes diffing via DifferenceKit
]
```

### Carthage

Add this to your `Cartfile`:
```
github "traderepublic/tr-sectionkit" ~> 1.0
```
> Note: Since the xcframework variant of `DifferenceKit` is linked against, make sure to build Carthage dependencies using the `--use-xcframeworks` option.
For more information please visit the [Carthage](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) repository.

## Quick Start

To get started, we need to initialise a `CollectionViewAdapter`. 
That object handles the communication to and from the `UICollectionView`.
Since we want to have multiple sections we'll use the `ListCollectionViewAdapter`, 
but if there would only be a single section we could also use the `SingleSectionCollectionViewAdapter`.

```swift
import SectionKit

final class MyCollectionViewController: UIViewController {

    private var collectionViewAdapter: CollectionViewAdapter!

    private let collectionView = UICollectionView(
        frame: .zero, 
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewAdapter = ListCollectionViewAdapter(
            viewController: self, 
            collectionView: collectionView,
            dataSource: self // no worries, we're going to add conformance to the protocol in a bit
        )
    }
}
```

In this example we're going to have two sections and we'll now define their respective models `FirstSectionModel` and `SecondSectionModel`:

```swift
struct FirstSectionModel {
    let items = ["Hello", "world"]
}

struct SecondSectionModel {
    let item = "Single item"
}
```

The next thing we want to do is to implement their corresponding `SectionController`. 
In this example, the first section shows a list of strings and the second section shows a single string. 
For both cases there are base classes we can inherit from:

```swift
class FirstSectionController: ListSectionController<FirstSectionModel, String> {
    override func items(for model: FirstSectionModel) -> [String] {
        model.items
    }

    override func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
        // cell types are automatically registered when dequeuing
        let cell = context.dequeueReusableCell(StringCell.self, for: indexPath)
        cell.label.text = items[indexPath]
        return cell
    }

    override func sizeForItem(at indexPath: SectionIndexPath, using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }
}

class SecondSectionController: SingleItemSectionController<SecondSectionModel, String> {
    override func item(for model: SecondSectionModel) -> String? {
        model.item
    }

    override func cellForItem(at indexPath: SectionIndexPath, in context: CollectionViewContext) -> UICollectionViewCell {
        // cell types are automatically registered when dequeuing
        let cell = context.dequeueReusableCell(StringCell.self, for: indexPath)
        cell.label.text = item
        return cell
    }

    override func sizeForItem(at indexPath: SectionIndexPath, using layout: UICollectionViewLayout, in context: CollectionViewContext) -> CGSize {
        CGSize(width: context.containerSize.width, height: 50)
    }
}
```

At last we want to implement the `ListCollectionViewAdapterDataSource` protocol. Here we're providing the `SectionController` for each model.

The sections both need a unique identifier, so the underlying `SectionController` can be recycled, which is necessary for animating updates. 
> Please note: Although the identifier needs to be unique across the list of sections, it also needs to be persistent across updates so the previous `SectionController` can be reused.

```swift

enum MyCollectionSectionId: Hashable {
    case first
    case second
}

protocol MyCollectionSection {
    var sectionId: MyCollectionSectionId { get }
}

extension FirstSectionModel: MyCollectionSection {
    var sectionId: MyCollectionSectionId { .first }
}

extension SecondSectionModel: MyCollectionSection {
    var sectionId: MyCollectionSectionId { .second }
}

extension MyCollectionViewController: ListCollectionViewAdapterDataSource {
    // this can be implemented in a viewmodel instead
    private func createSectionModels() -> [MyCollectionSection] {
        [FirstSectionModel(), SecondSectionModel()]
    }

    func sections(for adapter: CollectionViewAdapter) -> [Section] {
        createSectionModels().compactMap {
            switch $0 {
            case let model as FirstSectionModel:
                return Section(
                    id: model.sectionId,
                    model: model,
                    controller: FirstSectionController(model: model)
                )

            case let model as SecondSectionModel:
                return Section(
                    id: model.sectionId,
                    model: model,
                    controller: SecondSectionController(model: model)
                )

            default:
                assertionFailure("\(#function): unknown section model: \($0)")
                return nil
            }
        }
    }
}
```

That's it! Since both sections are completely decoupled from each other, they can be easily reused in other places in the app and 
writing unit tests becomes much easier!

As a final bonus, if you want animated updates, you can use the `DiffingListSectionController` (import DiffingSectionKit) instead of the "normal" `ListSectionController`. 
If you're running iOS 13+ you may also use the `FoundationDiffingListSectionController` that is already contained in the SectionKit module.

## Overview

The functionality is split into two modules:
- `SectionKit`:

    This package contains the core functionality. 

    **Please note**: `ListCollectionViewAdapter` and `ListSectionController` will not animate updates to the list of sections/items 
    and call `reloadData()`/`reloadSections(_:)` respectively. 
    On iOS 13+ you can use the `FoundationDiffingListCollectionViewAdapter` or `FoundationDiffingListSectionController`  
    to get animated updates. 
    When targeting iOS versions lower than 13, you can implement your own difference calculation by overriding 
    `calculateUpdate(from:to:)` or you can use a class contained in `DiffingSectionKit`.

    Besides that, the `SingleSectionCollectionViewAdapter`, `SingleModelSectionController` and 
    `SingleItemSectionController` support animated updates out of the box.

- `DiffingSectionKit`:

    This package extends `SectionKit` by containing three more base classes, `DiffingListCollectionViewAdapter`, 
    `DiffingListSectionController` and `ManualDiffingListSectionController`. 
    They simply override `calculateUpdate(from:to:)` where the difference between the old and new data is calculated 
    using [DifferenceKit](https://github.com/ra1028/DifferenceKit). Therefore, animations are performed
    when the list of sections/items is updated (separate inserts/deletes/moves instead of `reloadData()`/`reloadSections(_:)`).
    
### Supported APIs

The currently supported APIs are:
- `UICollectionViewDataSource`
- `UICollectionViewDataSourcePrefetching`
- `UICollectionViewDelegate`
- `UICollectionViewDragDelegate`
- `UICollectionViewDropDelegate`
- `UICollectionViewDelegateFlowLayout`
- `UIScrollViewDelegate`

Other APIs can be easily added by extending `ListCollectionViewAdapter` or `SingleSectionCollectionViewAdapter`.

### CollectionViewAdapter

- `ListCollectionViewAdapter`:

    A `CollectionViewAdapter` that contains a list of sections. Changes to that list will result in a call to
    `reloadData()` on the underlying `UICollectionView`.
    
- `SingleSectionCollectionViewAdapter`:

    A `CollectionViewAdapter` that contains a single section. It will perform animated updates to the list of sections of the `UICollectionView`, 
    but updates within the section are handled by the respective `SectionController`.

- `FoundationDiffingListCollectionViewAdapter` (iOS 13+):

    A `CollectionViewAdapter` that contains a list of sections. Separate inserts/deletes/moves will be performed when the list of sections change
    using [`Foundation.CollectionDifference`](https://developer.apple.com/documentation/foundation/data/3200261-difference) (which is only available on iOS 13+).
    Updates within a section are handled by the respective `SectionController`.

- `DiffingListCollectionViewAdapter` (DiffingSectionKit):

    A `CollectionViewAdapter` that contains a list of sections. Separate inserts/deletes/moves will be performed when the list of sections change
    using [DifferenceKit](https://github.com/ra1028/DifferenceKit).
    Updates within a section are handled by the respective `SectionController`.

### SectionController

- `BaseSectionController`:

    A base class that implements overridable methods/properties from the following protocols:
    - `SectionController`
    - `SectionDataSource`
    - `SectionDataSourcePrefetchingDelegate` (iOS 10+)
    - `SectionDelegate`
    - `SectionFlowDelegate`
    - `SectionDragDelegate` (iOS 11+)
    - `SectionDropDelegate` (iOS 11+)

- `SingleModelSectionController<Model>`:

    A `SectionController` that displays data of a single model. Unless overridden, `numberOfItems` will always 
    be `1` and a change to its `model` will perform a call to `reloadItems(at:)`.
    
    **Warning**: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
    
    This `SectionController` is typically used when there are one or multiple **different** cells from
    a single model. If however all items are semantically similar and one could derive an array of them,
    it is recommended to use the `ListSectionController` instead.

- `SingleItemSectionController<Model, Item>`:

    In contrast to the `SingleModelSectionController`, this `SectionController` will conditionally display `0` or `1` item and animate
    this change accordingly.
    
    **Warning**: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
    
    This `SectionController` is typically used when one item should be displayed conditionally.
    If multiple items should be displayed, it is recommended to use the `ListSectionController` instead.

- `ListSectionController<Model, Item>`:

    A `SectionController` that contains a list of items. Changes to that list will result in a call to
    `reloadSections(_:)` on the underlying `UICollectionView`.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items (almost) never changes or should not perform animated updates.

- `FoundationDiffingListSectionController<Model, Item: Hashable>` (iOS 13+):

    A `SectionController` that contains a list of items and animate the difference whenever there is an update.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items may dynamically change.

- `DiffingListSectionController<Model, Item: Differentiable>` (DiffingSectionKit):

    A `SectionController` that contains a list of items and animate the difference whenever there is an update.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items may dynamically change.
    
- `ManualDiffingListSectionController<Model, Item>` (DiffingSectionKit):
    
    A `SectionController` that contains a list of items and animate the difference whenever there is an update.
    
    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items may dynamically change.
    
    > Note: Compared to the `DiffingListSectionController` this class doesn't have a `Differentiable` constraint on the generic
    `Item` type, instead it requires closures in the init to get diffing information for an item.
