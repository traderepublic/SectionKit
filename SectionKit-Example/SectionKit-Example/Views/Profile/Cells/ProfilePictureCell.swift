import UIKit

class ProfilePictureCell: CollectionViewCell<ProfilePictureSectionViewModel> {

    // MARK: - Properties
    static let imageHeight: CGFloat = 120
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstraints()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration
    override func configure(with viewModel: ProfilePictureSectionViewModel) {
        imageView.image = viewModel.profilePicture
    }

    private func setUpConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Self.imageHeight),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }

    override class func size(for viewModel: ProfilePictureSectionViewModel, size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: Self.imageHeight)
    }

}
