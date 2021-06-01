import UIKit
import Utilities

internal final class ExampleCell: SelectionCollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
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
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: guide.topAnchor),
            guide.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            // greaterThanOrEqualTo constraint is needed so the cell can stretch the full width
            guide.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
        ])
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    internal func configure(with example: ExampleViewModelType) {
        label.text = example.name
    }
}
