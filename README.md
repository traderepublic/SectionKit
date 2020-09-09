# SectionKit
[![CI Status](https://github.com/traderepublic/tr-sectionkit/workflows/CI/badge.svg)](https://github.com/traderepublic/tr-sectionkit/actions)

**SectionKit** makes it possible to implement a data-drive `UICollectionView`. Since each section is implemented separately, it is independant from the `UICollectionView` it is used in and code can be easily reused.

## Installation

### Swift Package Manager

#### Automatically in Xcode:

- Click **File > Swift Packages > Add Package Dependency...**  
- Use the package URL `https://github.com/traderepublic/tr-sectionkit` to add SectionKit/DiffingSectionKit to your project.

#### Manually in your `Package.swift` file:

```swift
.package(url: "https://github.com/traderepublic/tr-sectionkit", from: "0.1")
```

## Overview

The functionality is split into two packages:
- `SectionKit`:

    This package contains the core funtionality. 

    `ListCollectionViewAdapter` and `ListSectionController` will not perform checking for difference and call 
    `reloadData()`/`reloadSections(_:)` instead. On iOS 13+ you may use `FoundationDiffingListCollectionViewAdapter` or `FoundationDiffingListSectionController` respectively to get animated updates. When targeting iOS versions lower than 13, 
    you could implement your own difference calculation by overriding `calculateUpdate(from:to:)`.

    Besides that, `SingleModelSectionController` and `SingleItemSectionController` support separate 
    inserts/deletes/moves out of the box.

- `DiffingSectionKit`:

    This package extends `SectionKit` by containing two more base classes, `DiffingListCollectionViewAdapter` and 
    `DiffingListSectionController`. Both simply override `calculateUpdate(from:to:)` where they calculate the difference
    between the old and new date using [DifferenceKit](https://github.com/ra1028/DifferenceKit) and thus animations are performed
    when the list of sections/items updated (separate inserts/deletes/moves instead of `reloadData()`/`reloadSections(_:)`).

### CollectionViewAdapter

- `ListCollectionViewAdapter`:

    A `CollectionViewAdapter` that contains a list of sections. Changes to that list will result in a call to
    `reloadData()` on the underlying `UICollectionView`.

- `FoundationDiffingListCollectionViewAdapter` (iOS 13+):

    A `CollectionViewAdapter` that contains a list of sections. Changes to that list will be checked 
    for the difference to the current value and separate inserts/deletes/moves will be performed
    using difference calculation of Foundations `CollectionDifference` (which is only available on iOS 13+).

- `DiffingListCollectionViewAdapter` (DiffingSectionKit):

    A `CollectionViewAdapter` that contains a list of sections. Changes to that list will be checked 
    for the difference to the current value and separate inserts/deletes/moves will be performed
    using difference calculation of [DifferenceKit](https://github.com/ra1028/DifferenceKit).

### SectionController

- `BaseSectionController`:

    A base class that implements overridable methods/properties from the following protocols:
    - `SectionController`
    - `SectionDataSource`
    - `SectionDelegate`
    - `SectionFlowDelegate`
    - `SectionDragDelegate` (iOS 11+)
    - `SectionDropDelegate` (iOS 11+)

- `SingleModelSectionController<Model: SectionModel>`:

    A `SectionController` that displays data of a single model. Unless overridden, `numberOfItems` will always 
    be `1` and a change to its `model` will perform a call to `reloadItems(at:)`.
    
    **Warning**: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
    
    This `SectionController` is typically used when there are one or multiple **different** cells from
    a single model. If however all items are the semantically similar and one could derive an array of models,
    it is recommended to use `ListSectionController` instead.

- `SingleItemSectionController<Model: SectionModel, Item: Equatable>`:

    In contrast to the `SingleModelSectionController`, this `SectionController` will conditionally display `0` or `1` item.
    
    **Warning**: If `numberOfItems` is overridden, `calculateUpdate(from:to:)` needs to be overridden as well.
    
    This `SectionController` is typically used when one item should be displayed conditionally.
    If however multiple items should be displayed, it is recommended to use `ListSectionController` instead.

- `ListSectionController<Model: SectionModel, Item>`:

    A `SectionController` that contains a list of items. Changes to that list will result in a call to
    `reloadSections(_:)` on the underlying `UICollectionView`.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items (almost) never changes or should not perform animated updates.

- `FoundationDiffingListSectionController<Model: SectionModel, Item: Hashable>` (iOS 13+):

    A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items may dynamically change.

- `DiffingListSectionController<Model: SectionModel, Item: Differentiable>` (DiffingSectionKit):

    A `SectionController` that contains a list of items and calculates the difference whenever there is an update.

    This `SectionController` is typically used when there are multiple semantically similar items
    of a model to be displayed and the list of items may dynamically change.
    
## Concept

![Diagram](./Resources/SectionKit.svg)
