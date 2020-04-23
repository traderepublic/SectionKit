import UIKit
import ReactiveSwift
import ReactiveCocoa

class StockCell: CollectionViewCell<StockViewModelType> {

    // MARK: - Properties
    static let mainStackViewInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
    static let mainStackViewSpacing: CGFloat = 16
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dotView, labelStackView])
        stackView.directionalLayoutMargins = Self.mainStackViewInsets
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = Self.mainStackViewSpacing
        stackView.alignment = .center
        return stackView
    }()

    static let dotWidth: CGFloat = 8
    private let dotView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = dotWidth / 2
        view.alpha = 0
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)
        view.setContentCompressionResistancePriority(.required, for: .vertical)
        return view
    }()

    static let labelStackViewSpacing: CGFloat = 8
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            priceLabel
        ])
        stackView.spacing = Self.labelStackViewSpacing
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        return label
    }()

    // MARK: - Initialization
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        contentView.addSubview(mainStackView)
        setUpConstraints()
    }

    override func configure(with viewModel: StockViewModelType) {
        titleLabel.reactive.text <~ viewModel.outputs.longName.producer
            .take(until: reactive.prepareForReuse)

        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.currencyCode = "EUR"
        currencyFormatter.locale = Locale(identifier: "de-DE")
        priceLabel.reactive.text <~ viewModel.outputs.prices.producer
            .take(until: reactive.prepareForReuse)
            .map { prices in
                if let latestPrice = prices.last?.price {
                    return currencyFormatter.string(from: NSNumber(value: latestPrice)) ?? "\(latestPrice)€"
                }
                return "-"
        }

        dotView.reactive.animatedPriceChange <~ viewModel.outputs.prices.producer
            .take(until: reactive.prepareForReuse)
            .map { prices -> PriceChange in
                let lastTwoPrices = prices.suffix(2)
                guard
                    let previousPrice = lastTwoPrices.first,
                    let currentPrice = lastTwoPrices.last
                    else { return .none }
                if previousPrice > currentPrice {
                    return .down
                }
                return .up
        }
    }

    override class func size(for viewModel: StockViewModelType, size: CGSize) -> CGSize {
        let maxWidth = size.width * 0.7
            - mainStackViewInsets.leading
            - mainStackViewInsets.trailing
            - mainStackViewSpacing * 2
            - dotWidth

        let maxSize = CGSize(width: maxWidth, height: size.height)
        let minHeight = mainStackViewSpacing

        let title = viewModel.outputs.longName.value
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]

        let titleHeight = height(for: title,
                                 maxSize: maxSize,
                                 with: titleAttributes)

        let height = minHeight + titleHeight
        return CGSize(width: size.width, height: height)
    }

    private static func height(for text: String,
                               maxSize: CGSize,
                               with attributes: [NSAttributedString.Key: Any]) -> CGFloat {

        let drawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin]
        let rect = text.boundingRect(with: maxSize, options: drawingOptions, attributes: attributes, context: nil)
        return ceil(rect.height)
    }

    private func setUpConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        dotView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            dotView.widthAnchor.constraint(equalToConstant: Self.dotWidth),
            dotView.heightAnchor.constraint(equalTo: dotView.widthAnchor),
        ])
    }
}

fileprivate enum PriceChange {
    case none
    case up
    case down
}

fileprivate extension UIView {
    func animatePriceChange(_ change: PriceChange) {
        switch change {
        case .up: backgroundColor = .systemGreen
        case .down: backgroundColor = .systemRed
        case .none: backgroundColor = .clear
        }
        alpha = 1
        UIViewPropertyAnimator(duration: 0.5, curve: .easeOut) {
            self.alpha = 0
        }.startAnimation()
    }
}

fileprivate extension Reactive where Base: UIView {
    var animatedPriceChange: BindingTarget<PriceChange> {
        makeBindingTarget { $0.animatePriceChange($1) }
    }
}
