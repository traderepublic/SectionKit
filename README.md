# SectionKit

![Diagram](./Resources/SectionKit.svg)

## Overview

### CollectionViewAdapter

### SectionController

- `BaseSectionController`: A base class that implements overridable methods/properties from the following protocols:
    - `SectionController`
    - `SectionDataSource`
    - `SectionDelegate`
    - `SectionFlowDelegate`
    - `SectionDragDelegate` (iOS 11+)
    - `SectionDropDelegate` (iOS 11+)
- `SingleModelSectionController<Model: SectionModel>: BaseSectionController`
- `SingleItemSectionController<Model: SectionModel, Item: Equatable>: BaseSectionController`
- `ListSectionController<Model: SectionModel, Item>: BaseSectionController`
- `FoundationDiffingListSectionController<Model: SectionModel, Item: Hashable>: ListSectionController<Model, Item>` (iOS 13+)
