import UIKit
import ReactiveSwift
import ReactiveCocoa

class PortfolioHeaderCell: CollectionViewCell<PortfolioHeaderCellViewModelType> {
    // MARK: - Properties

    static let mainStackViewInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
    static let mainStackViewSpacing: CGFloat = 32
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleStackView])
        stackView.directionalLayoutMargins = Self.mainStackViewInsets
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.axis = .vertical
        stackView.spacing = Self.mainStackViewSpacing
        return stackView
    }()

    static let titleStackViewSpacing: CGFloat = 8
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, differenceLabel])
        stackView.spacing = Self.titleStackViewSpacing
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    private let differenceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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

    override func configure(with viewModel: PortfolioHeaderCellViewModelType) {
        titleLabel.reactive.text <~ viewModel.outputs.title.producer
            .take(until: reactive.prepareForReuse)

        differenceLabel.reactive.text <~ viewModel.outputs.difference.producer
            .take(until: reactive.prepareForReuse)
    }

    override class func size(for viewModel: PortfolioHeaderCellViewModelType, size: CGSize) -> CGSize {
        let maxWidth = size.width
            - mainStackViewInsets.leading
            - mainStackViewInsets.trailing
            - titleStackViewSpacing

        let maxSize = CGSize(width: maxWidth, height: size.height)
        let minHeight = mainStackViewSpacing

        let title = viewModel.outputs.title.value
        let titleAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .largeTitle)]

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
}

// MARK: - Layout
extension PortfolioHeaderCell {
    private func setUpConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
        ])
    }
}
