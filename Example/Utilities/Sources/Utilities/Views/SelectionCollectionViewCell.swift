import UIKit

open class SelectionCollectionViewCell: UICollectionViewCell {
    override open var backgroundColor: UIColor? {
        get { backgroundView?.backgroundColor }
        set { backgroundView?.backgroundColor = newValue }
    }

    open var selectedBackgroundColor: UIColor? {
        get { selectedBackgroundView?.backgroundColor }
        set { selectedBackgroundView?.backgroundColor = newValue }
    }

    open var cornerRadius: CGFloat {
        get { contentView.layer.cornerRadius }
        set {
            contentView.layer.cornerRadius = newValue
            backgroundView?.layer.cornerRadius = newValue
            selectedBackgroundView?.layer.cornerRadius = newValue
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder: NSCoder) {
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
