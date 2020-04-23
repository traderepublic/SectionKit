import UIKit
import ReactiveSwift
import ReactiveCocoa

class StockSectionHeaderView: UICollectionReusableView {
    // MARK: - Properties
    private var viewModel: StockSectionViewModel?

    static var identifier: String { String(describing: self) }

    static let mainStackViewInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
    static let mainStackViewSpacing: CGFloat = 16
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.directionalLayoutMargins = Self.mainStackViewInsets
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = Self.mainStackViewSpacing
        stackView.alignment = .center
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
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
        backgroundColor = UIColor.systemBackground
        addSubview(mainStackView)
        setUpConstraints()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    func configure(with viewModel: StockSectionViewModel) {
        self.viewModel = viewModel

        titleLabel.reactive.text <~ viewModel.outputs.title.producer
            .take(until: reactive.prepareForReuse)
    }

    private func setUpConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor)
        ])
    }
}
