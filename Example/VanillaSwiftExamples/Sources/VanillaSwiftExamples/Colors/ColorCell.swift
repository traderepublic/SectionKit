import UIKit
import Utilities

final class ColorCell: SelectionCollectionViewCell {
    var color: UIColor = .clear {
        didSet { updateBackgroundColor() }
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
        updateBackgroundColor()
    }

    private func updateBackgroundColor() {
        backgroundColor = color
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        color = .clear
    }
}
