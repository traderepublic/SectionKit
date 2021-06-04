import UIKit
import Utilities

extension NumbersCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = NumbersViewModel(navigation: self)
        return NumbersViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
