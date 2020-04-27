![section kit logo](https://github.com/traderepublic/tr-sectionkit/blob/introduction/Resources/SectionKit.png)

In this tutorial we will guide you through the most important classes and APIs
you will need to set up a simple view containing multiple, reusable and  diffable sections.
___
To get started open the example project, wait for Xcode to check out the SwiftPM dependencies 
and run the app. You will be greeted with an empty screen.
To bring a bit of life into it, let's add some information to that view.

The first thing to do is to add a `SectionAdapter` to the `PortfolioViewController`. 
The `SectionAdapter`, as the name suggests, acts as mediator between the collection view 
and it's datasources. In our case we will have three datasources, one for each section, 
each controlled by their individual `SectionController`. We already have an optional 
reference declared in our `PortfolioViewController`, so let's go ahead and initialise 
it in `viewDidLoad`.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    sectionAdapter = SectionAdapter(viewController: self,
                                    collectionView: collectionView,
                                    sectionControllers: [])
}
```

This creates a `SectionAdapter` which takes control of our `collectionView` 
by setting itself as the datasource and delegate. The next logical step would be to add
our first section.

Let's start with adding a title section that will display the combined amount of stock value 
we have in our portfolio. We already prepared a section for you to use, so go ahead and 
initialise it below our `collectionView` definition:

```swift
private var sectionAdapter: SectionAdapter!
private let headerSection = PortfolioHeaderSectionController()
```

Next thing we have to do is to add this `headerSection` to our
`sectionAdapter`'s array of sections controllers. Go back to the `viewDidLoad` 
and add it to the initialiser.

```swift
sectionAdapter = SectionAdapter(viewController: self,
                                collectionView: collectionView,
                                sectionControllers: [headerSection])
```

Last thing to do before seing our glorious `headerSection` is to enable a reactive 
binding to fill the section with actual data stored in our `viewModel`. Find the 
`private func setUpBindings()` and uncomment the line of code in it.
Run the app et voilà, our collectionView is
displaying the value of the `viewModel`. However, we do not have any stocks yet, 
let's change that now. The steps to add a new section to a `SectionAdapter` are 
the same for any `SectionController`, create a
reference and add it to your `SectionAdapter`'s `sectionControllers`. You can 
either do that in the initialiser or call: 
```swift
sectionAdapter.sectionControllers.append(mySectionController)
```
For simplicity we're going to add it to the initialiser as we did for the
`headerSection`.

```swift
// 1
private lazy var stockSection = StockSectionController(viewModel: viewModel.outputs.stockSection)

override func viewDidLoad() {
    super.viewDidLoad()
    setUpView()
    // 2
    sectionAdapter = SectionAdapter(viewController: self,
                                    collectionView: collectionView,
                                    sectionControllers: [headerSection, stockSection])
}
```

1. We're creating an instance of `StockSectionController`. Notice the `lazy` keyword because we're using `self.viewModel` to initialise the section.
2. Add the `stockSection` to the list of section controllers in the `SectionAdapter`

Open the `StockSectionController` and you will be greeted by a very simple implementation. `SectionKit` offers different level of abstraction to fit your needs. If you want to learn more about the different classes we provide, please resort to our ___DOCUMENTATION URL___

```swift
// 1
final class StockSectionController: DiffingSectionController<StockViewModel> {
    // MARK: - Properties
    let viewModel: StockSectionViewModel

    // MARK: - Initializer
    init(viewModel: StockSectionViewModel) {
        self.viewModel = viewModel
        super.init()
        // 2
        reactive.items <~ viewModel.outputs.stocks
    }
}
```
1. We're subclassing `DiffingSectionController` and provide a generic type of `StockViewModel`. The generic type of `DiffingSectionController` specifically is contraint to `Differentiable` (to provide rich diffs) and `CollectionViewCellRepresentable`. This helps `SectionKit` to dequeue the correct cells later on.
2. We're using a reactive binding here to update the items in this section whenever the property in the `viewModel` changes. More about why we do that and why we use a `DiffingSectionController` here later. For now, this is just providing us with a predefined list of stocks.

Build and run to see our new list of stocks being placed below our portfolio value. Two things are missing to make this look beautiful though.
First of all is a proper description of the list. We can do that by adding a header to our `StockSectionController`. The `StockSectionHeaderView` needed for that already exists and we just have to tell our `SectionController` to use it.
To display a custom header we need to override two methods:
`headerView(at:SectionIndexPath)` and `referenceSizeForHeader(using:UICollectionViewLayout)`.
Go ahead and add the following code to the `StockSectionController`.

```swift
// MARK: - Header
// 1
override func headerView(at indexPath: SectionIndexPath) -> UICollectionReusableView {
    // 2
    let headerView = context!.dequeueReusableHeaderView(StockSectionHeaderView.self,
                                                        for: indexPath.externalRepresentation)
    headerView.configure(with: viewModel)
    return headerView
}
```
1. We're passing in a `SectionIndexPath`. This object keeps track of which section we're in and helps adjusting the index when using `CompositeSectionController`.
2. This is the first time we're using our `CollectionContext`. The context holds among other things information about:
 - which `UIViewController` we're presenting the `UICollectionView` in,
 - the `UICollectionView` we're working with and
 - useful methods to help you size your cells and header/footer views

This will dequeue the correct header view for us, but without the correct size it will not display anything as it will default to `UIKit` default values (`CGSize.zero`).


```swift
// 1
override func referenceSizeForHeader(using layout: UICollectionViewLayout) -> CGSize {
    // 2
    return CGSize(width: context!.insetContainerSize.width, height: 50)
}
```
1. We're passing in a `UICollectionViewLayout` for you to use if you want to. However, in our example we will be leveraging the context to get the correct size.
2. We're using one of the provided sizing methods to include custom content inset from `UICollectionView` in our size.

Build and run and see our new header. Now, our portfolio value looks a bit off. We can fix that by opening the `PortfolioViewModel`.

Replace
```swift
let portfolioValue = SignalProducer<Float?, Never>(value: 9999.99)
```

with
```swift
let portfolioValue = stockSection.outputs.stocks.producer
    // 1
    .flatMap(.latest) { stocks -> SignalProducer<[Float?], Never> in
        guard !stocks.isEmpty else {
            return SignalProducer(value: [])
        }
        return SignalProducer.combineLatest(stocks.map { $0.prices.map { $0.last?.price } })
    }
    // 2
    .map { currentStockValues -> Float? in
        guard !currentStockValues.isEmpty else {
            return nil
        }
        var totalValue: Float = 0
        for stockValue in currentStockValues {
            guard let value = stockValue else {
                return nil
            }
            totalValue += value
        }
        return totalValue
    }
```

Going into detail of that reactive chain would be beyond the scope of this introduction so let's just quickly go over it.

1. We're mapping to the most current price of each stock.
2. We're iterating over the prices and add them together

Build and run and we see our portfolio value update as soon as all our stocks have at least one price.

---
