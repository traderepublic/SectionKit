import UIKit

struct ExampleCoordinator: ExampleNavigation {
    private unowned let navigationController: UINavigationController
    private let nextCoordinator: Presentable

    init(navigationController: UINavigationController, nextCoordinator: Presentable) {
        self.navigationController = navigationController
        self.nextCoordinator = nextCoordinator
    }

    func show(example: ExampleViewModelType) {
        nextCoordinator.present(segue: .push(onto: navigationController))
    }
}
