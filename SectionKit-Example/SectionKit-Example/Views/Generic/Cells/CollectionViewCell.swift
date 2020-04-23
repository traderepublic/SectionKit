import UIKit

class CollectionViewCell<T>: UICollectionViewCell {

    /// Use this method to configure your cell with content. Needs to be overriden in subclasses.
    /// - Parameter viewModel: A view model describing the cells content.
    func configure(with viewModel: T) {
        preconditionFailure("This needs to be overriden")
    }

    /// Calculates the size for the cell. Should be overriden in subclasses.
    /// Default value is `CGSize(width: 50, height: 50)`
    /// - Parameter size: The maximum size this cell can have.
    /// - Parameter viewModel: The view model holding the content for the cell.
    /// - Returns: The `height` and `width` calculated by the cells content.
    class func size(for viewModel: T, size: CGSize) -> CGSize {
        CGSize(width: 50, height: 50)
    }

    // MARK: - Initializer

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
        selectedBackgroundColor = .secondarySystemBackground
    }

    // MARK: - UICollectionViewCell

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

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        layer.zPosition = CGFloat(layoutAttributes.zIndex)
    }
}
