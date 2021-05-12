import UIKit

final class ColorCell: SelectionCollectionViewCell {
    var color: UIColor = .clear {
        didSet { updateBackgroundColor() }
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
