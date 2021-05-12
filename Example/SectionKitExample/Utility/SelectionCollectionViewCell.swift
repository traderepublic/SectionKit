import UIKit

class SelectionCollectionViewCell: UICollectionViewCell {
    override var backgroundColor: UIColor? {
        get { backgroundView?.backgroundColor }
        set { backgroundView?.backgroundColor = newValue }
    }

    var selectedBackgroundColor: UIColor? {
        get { selectedBackgroundView?.backgroundColor }
        set { selectedBackgroundView?.backgroundColor = newValue }
    }

    var cornerRadius: CGFloat {
        get { contentView.layer.cornerRadius }
        set {
            contentView.layer.cornerRadius = newValue
            backgroundView?.layer.cornerRadius = newValue
            selectedBackgroundView?.layer.cornerRadius = newValue
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
        super.backgroundColor = nil
        backgroundView = UIView()
        backgroundView?.isOpaque = true
        selectedBackgroundView = UIView()
        backgroundColor = .systemBackground
        selectedBackgroundColor = .systemFill
    }
}
