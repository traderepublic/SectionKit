import UIKit
import Utilities

internal final class NumberCell: LabelCell {
    internal var number: Int? {
        get { Int(label.text ?? "") }
        set {
            if let newValue = newValue {
                label.text = "\(newValue)"
            } else {
                label.text = nil
            }
        }
    }

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        number = nil
    }
}
