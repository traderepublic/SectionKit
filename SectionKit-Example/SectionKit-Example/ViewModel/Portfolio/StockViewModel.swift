import Foundation
import ReactiveCocoa
import ReactiveSwift

protocol StockViewModelType {
    var inputs: StockViewModelInputs { get }
    var outputs: StockViewModelOutputs { get }
}

protocol StockViewModelInputs {
    var moveObserver: Signal<(from: Int, to: Int), Never>.Observer { get }
    var deletePressedObserver: Signal<(), Never>.Observer { get }
}

protocol StockViewModelOutputs {
    var longName: Property<String> { get }
    var prices: Property<[(price: Float, date: Date)]> { get }
    var currentPrice: Property<Float?> { get }
}

final class StockViewModel:
    ViewModel,
    StockViewModelType,
    StockViewModelInputs,
    StockViewModelOutputs
{

    // MARK: - StockViewModelType
    var inputs: StockViewModelInputs { self }
    var outputs: StockViewModelOutputs { self }

    // MARK: - StockViewModelInputs
    let (move, moveObserver) = Signal<(from: Int, to: Int), Never>.pipe()
    let (deletePressed, deletePressedObserver) = Signal<(), Never>.pipe()

    // MARK: - StockViewModelOutputs
    let longName: Property<String>
    let prices: Property<[(price: Float, date: Date)]>
    let currentPrice: Property<Float?>

    // MARK: - Initializer

    init(longName: String,
         priceProducer: SignalProducer<(price: Float, date: Date), Never>) {
        self.longName = Property(value: longName)

        let pricesProducer: SignalProducer<[(price: Float, date: Date)], Never> = priceProducer
            // append new values into array and keep only the newest 10 values
            .scan([]) { currentPrices, newPrice -> [(price: Float, date: Date)] in
                return Array((currentPrices + [newPrice]).suffix(20))
        }
        prices = Property(initial: [], then: pricesProducer)

        currentPrice = prices.map { $0.last?.price }
        super.init()
    }
}
