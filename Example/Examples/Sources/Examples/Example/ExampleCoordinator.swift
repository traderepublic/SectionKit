import UIKit
import Utilities

internal struct ExampleCoordinator {
    internal unowned let navigationController: UINavigationController
    internal let presentable: () -> Presentable

    internal init(
        navigationController: UINavigationController,
        presentable: @autoclosure @escaping () -> Presentable
    ) {
        self.navigationController = navigationController
        self.presentable = presentable
    }
}
