import UIKit
import Utilities

final class NameCell: LabelCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func set(name: String) {
        label.text = name
    }
}
