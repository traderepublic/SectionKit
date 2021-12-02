import UIKit
import Utilities

extension EmojisCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = EmojisViewModel()
        return EmojisViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
