import Foundation
import ReactiveCocoa
import ReactiveSwift

protocol ChartCellViewModelType {
    var inputs: ChartCellViewModelInputs { get }
    var outputs: ChartCellViewModelOutputs { get }
}

protocol ChartCellViewModelInputs {
    var moveObserver: Signal<(from: Int, to: Int), Never>.Observer { get }
    var deletePressedObserver: Signal<(), Never>.Observer { get }
}

protocol ChartCellViewModelOutputs {
    var id: UUID { get }
    var title: Property<String> { get }
    var difference: Property<String> { get }
    var portfolioValueHistorie: Property<[Float]> { get }
}

final class ChartCellViewModel:
    ViewModel,
    ChartCellViewModelType,
    ChartCellViewModelInputs,
    ChartCellViewModelOutputs
{

    // MARK: - ChartCellViewModelType
    var inputs: ChartCellViewModelInputs { self }
    var outputs: ChartCellViewModelOutputs { self }

    // MARK: - ChartCellViewModelInputs
    let (move, moveObserver) = Signal<(from: Int, to: Int), Never>.pipe()
    let (deletePressed, deletePressedObserver) = Signal<(), Never>.pipe()

    // MARK: - PortfolioHeaderCellViewModelOutputs
    let title: Property<String>
    let difference: Property<String>
    let portfolioValueHistorie: Property<[Float]>

    // MARK: - Initializer

    init(portfolioValueProducer: SignalProducer<Float?, Never>) {
        let portfolioValueHistorieProducer: SignalProducer<[Float], Never> = portfolioValueProducer
            // append new values into array and keep only the newest 10 values
            .scan(into: []) { (currentPrices: inout [Float], newPrice: Float?) in
                if let newPrice = newPrice {
                    currentPrices.append(newPrice)
                } else {
                    currentPrices.removeAll()
                }
        }
        portfolioValueHistorie = Property(initial: [],
                                          then: portfolioValueHistorieProducer)

        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "EUR"
        currencyFormatter.locale = Locale(identifier: "de-DE")
        title = Property(initial: "-", then: portfolioValueHistorie.map {
            if let currentValue = $0.last {
                return currencyFormatter.string(from: NSNumber(value: currentValue)) ?? "\(currentValue)€"
            }
            return "-"
        })

        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 2
        difference = Property(initial: "-", then: portfolioValueHistorie.map {
            if let firstValue = $0.first, let currentValue = $0.last {
                let percentValue = currentValue / firstValue - 1
                return percentFormatter.string(from: NSNumber(value: percentValue)) ?? "\(percentValue * 100)%"
            }
            return "-"
        })
        super.init()
    }
}
