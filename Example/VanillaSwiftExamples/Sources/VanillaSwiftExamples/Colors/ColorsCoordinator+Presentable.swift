import UIKit
import Utilities

extension ColorsCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = ColorsViewModel(navigation: self)
        return ColorsViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
