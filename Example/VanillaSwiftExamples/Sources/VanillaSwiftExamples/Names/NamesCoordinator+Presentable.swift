import UIKit
import Utilities

extension NamesCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = NamesViewModel(navigation: self)
        return NamesViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
