import Foundation
import ReactiveCocoa
import ReactiveSwift

protocol PortfolioViewModelType {
    var inputs: PortfolioViewModelInputs { get }
    var outputs: PortfolioViewModelOutputs { get }
}

protocol PortfolioViewModelInputs {
}

protocol PortfolioViewModelOutputs {
    var portfolioHeaderSection: Property<PortfolioHeaderCellViewModel> { get }
    var stockSection: StockSectionViewModel { get }
    var watchlistSection: StockSectionViewModel { get }
}

final class PortfolioViewModel:
    ViewModel,
    PortfolioViewModelType,
    PortfolioViewModelInputs,
    PortfolioViewModelOutputs
{

    // MARK: - PortfolioViewModelType

    var inputs: PortfolioViewModelInputs { self }
    var outputs: PortfolioViewModelOutputs { self }

    // MARK: - PortfolioViewModelInputs
    var addStockPressedObserver: Signal<StockViewModel, Never>.Observer {
        stockSection.inputs.addStockPressedObserver
    }

    // MARK: - PortfolioViewModelOutputs
    let portfolioHeaderSection: Property<PortfolioHeaderCellViewModel>

    let stockSection = StockSectionViewModel(title: "Investments")
    let watchlistSection = StockSectionViewModel(title: "Watchlist")

    // MARK: - Initializer
    override init() {
        let portfolioValue = SignalProducer<Float?, Never>(value: 9999.99)
        portfolioHeaderSection = Property(value: PortfolioHeaderCellViewModel(portfolioValueProducer: portfolioValue))

        super.init()

        addDefaultStocks()
    }

    private func addDefaultStocks() {
        let appleStock = StockViewModel(longName: "Apple Inc.",
                                        priceProducer: Self.createPriceProducer(basePrice: 220,
                                                                                interval: .milliseconds(Int.random(in: 2000...5000))))
        let facebookStock = StockViewModel(longName: "Facebook Inc.",
                                           priceProducer: Self.createPriceProducer(basePrice: 150,
                                                                                   interval: .milliseconds(Int.random(in: 2000...5000))))
        let teslaStock = StockViewModel(longName: "Tesla Inc.",
                                        priceProducer: Self.createPriceProducer(basePrice: 420,
                                                                                interval: .milliseconds(Int.random(in: 2000...5000))))
        let amazonStock = StockViewModel(longName: "Amazon Inc.",
                                         priceProducer: Self.createPriceProducer(basePrice: 1337,
                                                                                 interval: .milliseconds(Int.random(in: 2000...5000))))
        let microsoftStock = StockViewModel(longName: "Microsoft Corp.",
                                            priceProducer: Self.createPriceProducer(basePrice: 160,
                                                                                    interval: .milliseconds(Int.random(in: 2000...5000))))
        let twitterStock = StockViewModel(longName: "Twitter Inc.",
                                          priceProducer: Self.createPriceProducer(basePrice: 26.10,
                                                                                  interval: .milliseconds(Int.random(in: 2000...5000))))
        let beyondMeat = StockViewModel(longName: "Beyond Meat Inc.",
                                          priceProducer: Self.createPriceProducer(basePrice: 82.48,
                                                                                  interval: .milliseconds(Int.random(in: 2000...5000))))
        stockSection.addStockPressedObserver.send(value: appleStock)
        stockSection.addStockPressedObserver.send(value: facebookStock)
        stockSection.addStockPressedObserver.send(value: teslaStock)
        stockSection.addStockPressedObserver.send(value: amazonStock)

        watchlistSection.addStockPressedObserver.send(value: microsoftStock)
        watchlistSection.addStockPressedObserver.send(value: twitterStock)
        watchlistSection.addStockPressedObserver.send(value: beyondMeat)
    }

    static func createPriceProducer(basePrice: Float,
                                    interval: DispatchTimeInterval) -> SignalProducer<(price: Float, date: Date), Never> {
        SignalProducer.timer(interval: interval,
                             on: QueueScheduler.main)
            .scan((price: basePrice, date: Date())) { (scanValue, date) in
                let (currentPrice, _) = scanValue
                let maximumPriceChangePerTick = currentPrice / 200 // allow a maximum of 0.5% change per tick
                // cap the price generation to the range from 0.5 - 1.5 times the base price
                if currentPrice > basePrice * 1.05 {
                    return (price: currentPrice + (Float.random(in: -maximumPriceChangePerTick...0)),
                            date: date)
                }
                if currentPrice < basePrice * 0.95 {
                    return (price: currentPrice + (Float.random(in: 0...maximumPriceChangePerTick)),
                            date: date)
                }
                return (price: currentPrice + (Float.random(in: -maximumPriceChangePerTick...maximumPriceChangePerTick)),
                        date: date)
        }
    }
}
