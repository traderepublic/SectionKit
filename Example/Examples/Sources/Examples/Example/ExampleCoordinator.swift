import UIKit
import Utilities

internal struct ExampleCoordinator {
    internal unowned let navigationController: UINavigationController
    internal let nextCoordinator: () -> Presentable

    internal init(
        navigationController: UINavigationController,
        nextCoordinator: @autoclosure @escaping () -> Presentable
    ) {
        self.navigationController = navigationController
        self.nextCoordinator = nextCoordinator
    }
}
