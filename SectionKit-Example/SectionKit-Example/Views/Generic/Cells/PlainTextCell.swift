import UIKit

class PlainTextCell: CollectionViewCell<String> {
    // MARK: - Properties
    let titleLabel = UILabel()

    static let titleStackViewMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel])
        stackView.directionalLayoutMargins = Self.titleStackViewMargins
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleStackView)
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func configure(with viewModel: String) {
        titleLabel.text = viewModel
    }

    override class func size(for viewModel: String, size: CGSize) -> CGSize {
        let maxSize = CGSize(width: size.width, height: .greatestFiniteMagnitude)
        let titleHeight = NSAttributedString(string: viewModel)
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
