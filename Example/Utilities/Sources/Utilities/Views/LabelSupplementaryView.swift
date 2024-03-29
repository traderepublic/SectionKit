import UIKit

open class LabelSupplementaryView: UICollectionReusableView {
    public let label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .secondaryLabel
        return label
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        directionalLayoutMargins = NSDirectionalEdgeInsets(vertical: 8, horizontal: 24)
        setUpViewHierarchy()
    }

    private func setUpViewHierarchy() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            layoutMarginsGuide.bottomAnchor.constraint(equalTo: label.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            layoutMarginsGuide.trailingAnchor.constraint(equalTo: label.trailingAnchor)
        ])
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    override open var intrinsicContentSize: CGSize {
        label.intrinsicContentSize.adding(padding: directionalLayoutMargins)
    }
}
