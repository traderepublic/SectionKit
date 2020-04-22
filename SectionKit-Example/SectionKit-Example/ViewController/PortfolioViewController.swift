import UIKit

class PortfolioViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: PortfolioViewModel

    // MARK: - Initialization
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
}
