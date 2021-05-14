import UIKit

final class ExampleCell: LabelCell {
    override var isHighlighted: Bool {
        didSet { label.isHighlighted = isHighlighted }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        cornerRadius = 4
        backgroundColor = .secondarySystemGroupedBackground
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.highlightedTextColor = .secondaryLabel
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }

    func configure(with example: ExampleViewModelType) {
        label.text = example.name
    }
}
