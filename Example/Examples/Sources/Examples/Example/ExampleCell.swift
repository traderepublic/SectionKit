import UIKit
import Utilities

internal final class ExampleCell: SelectionCollectionViewCell {
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            nameLabel,
            descriptionLabel
        ])
        stack.axis = .vertical
        stack.spacing = 4
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        cornerRadius = 4
        backgroundColor = .systemGroupedBackground
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(vertical: 16, horizontal: 24)
        setUpViewHierarchy()
    }

    private func setUpViewHierarchy() {
        contentView.addSubview(labelStack)
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            labelStack.topAnchor.constraint(equalTo: guide.topAnchor),
            guide.bottomAnchor.constraint(equalTo: labelStack.bottomAnchor),
            labelStack.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            guide.trailingAnchor.constraint(equalTo: labelStack.trailingAnchor)
        ])
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        descriptionLabel.text = nil
        descriptionLabel.isHidden = true
    }

    internal func configure(with example: ExampleViewModelType) {
        nameLabel.text = example.name
        descriptionLabel.text = example.description
        descriptionLabel.isHidden = example.description == nil
    }
}
