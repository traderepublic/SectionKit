import UIKit
import Utilities

internal final class ExampleCell: SelectionCollectionViewCell {
    private let label = UILabel()

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24)
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: guide.topAnchor),
            guide.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            // needed so the cell can stretch the full width
            guide.trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
        ])
        cornerRadius = 4
        backgroundColor = .systemGroupedBackground
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    internal func configure(with example: ExampleViewModelType) {
        label.text = example.name
    }
}
