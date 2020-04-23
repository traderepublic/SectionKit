import Foundation
import ReactiveCocoa
import ReactiveSwift

protocol StockSectionViewModelType {
    var inputs: StockSectionViewModelInputs { get }
    var outputs: StockSectionViewModelOutputs { get }
}

protocol StockSectionViewModelInputs {
    var addStockPressedObserver: Signal<StockViewModel, Never>.Observer { get }
    var mutableStocks: MutableProperty<[StockViewModel]> { get }
}

protocol StockSectionViewModelOutputs {
    var title: Property<String> { get }
    var stocks: Property<[StockViewModel]> { get }
}

final class StockSectionViewModel:
    ViewModel,
    StockSectionViewModelType,
    StockSectionViewModelInputs,
    StockSectionViewModelOutputs
{

    // MARK: - StockSectionViewModelType
    var inputs: StockSectionViewModelInputs { self }
    var outputs: StockSectionViewModelOutputs { self }

    // MARK: - StockSectionViewModelInputs
    var (addStock, addStockPressedObserver) = Signal<StockViewModel, Never>.pipe()
    let mutableStocks: MutableProperty<[StockViewModel]>

    // MARK: - StockSectionViewModelOutputs
    let title: Property<String>
    let stocks: Property<[StockViewModel]>

    // MARK: - Initializer
    init(title: String) {
        self.title = Property(value: title)

        mutableStocks = MutableProperty([])

        stocks = Property(capturing: mutableStocks)

        // Add stocks
        mutableStocks <~ stocks.producer
            .sample(with: addStock)
            .map { oldStocks, stock in
                var newStocks = oldStocks
                newStocks.append(stock)
                return newStocks
        }

        // Delete stocks on press
        mutableStocks <~ stocks.producer
            .skipRepeats()
            .flatMap(.latest) { items in
                SignalProducer(value: items)
                    .sample(with: SignalProducer.merge(items.map {
                        SignalProducer(value: $0).sample(on: $0.deletePressed)
                    }))
        }
        .map { items, deletedItem in
            var newItems = items
            newItems.removeAll { $0.id == deletedItem.id }
            return newItems
        }

        // Move stocks
        mutableStocks <~ stocks.producer
            .skipRepeats()
            .flatMap(.latest) { items in
                SignalProducer(value: items)
                    .sample(with: Signal.merge(items.map { $0.move }))
        }
        .map { (items, move) in
            let (from, to) = move
            var newItems = items
            let element = newItems.remove(at: from)
            newItems.insert(element, at: to)
            return newItems
        }

        super.init()
    }
}
