import UIKit

open class LabelCell: SelectionCollectionViewCell {
    public let label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(vertical: 16, horizontal: 24)
        setUpViewHierarchy()
    }

    private func setUpViewHierarchy() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: guide.topAnchor),
            guide.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            guide.trailingAnchor.constraint(equalTo: label.trailingAnchor),
        ])
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}
