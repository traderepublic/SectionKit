import UIKit
import Utilities

extension ColorsCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = ColorsViewModel(
            colors: [
                .systemYellow,
                .systemOrange,
                .systemRed,
                .systemPink,
                .systemPurple,
                .systemIndigo,
                .systemTeal,
                .systemBlue,
                .systemGreen,
                .white,
                .systemGray,
                .systemGray2,
                .systemGray3,
                .systemGray4,
                .systemGray5,
                .systemGray6,
                .black
            ],
            navigation: self
        )
        return ColorsViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
