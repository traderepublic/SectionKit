import UIKit

extension ColorCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = ColorViewModel(
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
        return ColorViewController(viewModel: viewModel)
    }

    @discardableResult
    func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
