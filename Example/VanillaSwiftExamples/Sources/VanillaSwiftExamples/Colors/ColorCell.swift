import UIKit
import Utilities

internal final class ColorCell: SelectionCollectionViewCell {
    internal var color: UIColor = .clear {
        didSet { updateBackgroundColor() }
    }

    override internal init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    // Test

    required internal init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        updateBackgroundColor()
    }

    private func updateBackgroundColor() {
        backgroundColor = color
    }

    override internal func prepareForReuse() {
        super.prepareForReuse()
        color = .clear
    }
}
