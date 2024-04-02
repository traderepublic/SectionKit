import UIKit
import Utilities

final class NameSectionHeaderView: LabelSupplementaryView {
    private var headerPressedHandler: (() -> Void)?

    private lazy var closeIcon = UIImageView(image: .init(systemName: "x.circle"))

    private lazy var gestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(headerPressed)
    )

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        addGestureRecognizer(gestureRecognizer)
        backgroundColor = .systemGray6
        label.font = .preferredFont(forTextStyle: .title2)
        addSubview(closeIcon)
        closeIcon.translatesAutoresizingMaskIntoConstraints = false
        closeIcon.tintColor = .black
        NSLayoutConstraint.activate([
            closeIcon.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor),
            closeIcon.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }

    @objc private func headerPressed() {
        headerPressedHandler?()
    }

    func set(
        title: String,
        headerPressedHandler: @escaping () -> Void
    ) {
        self.label.text = title
        self.headerPressedHandler = headerPressedHandler
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        headerPressedHandler = nil
    }
}
