import UIKit
import Utilities

final class NumberCell: LabelCell {
    var number: Int? {
        get { Int(label.text ?? "") }
        set {
            if let newValue = newValue {
                label.text = "\(newValue)"
            } else {
                label.text = nil
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        number = nil
    }
}
