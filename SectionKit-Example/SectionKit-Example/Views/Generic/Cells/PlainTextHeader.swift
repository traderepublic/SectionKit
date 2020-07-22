import UIKit

class PlainTextHeader: CollectionViewCell<String> {

    // MARK: - Properties
    static let titleFont = UIFont.preferredFont(forTextStyle: .caption1)
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Self.titleFont
        return label
    }()

    static let titleStackViewMargins = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.directionalLayoutMargins = Self.titleStackViewMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleStackView)
        setUpConstraints()
        backgroundColor = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    override func configure(with viewModel: String) {
        titleLabel.text = viewModel
    }

    override class func size(for viewModel: String, size: CGSize) -> CGSize {
        let maxSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        let titleHeight = NSAttributedString(string: viewModel, attributes: [.font: titleFont])
            .boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], context: nil)
            .height

        let height = titleHeight
            + Self.titleStackViewMargins.top
            + Self.titleStackViewMargins.bottom

        return CGSize(width: size.width, height: height)
    }

    private func setUpConstraints() {
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: titleStackView.trailingAnchor),
            titleStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: titleStackView.bottomAnchor),
        ])
    }
}
