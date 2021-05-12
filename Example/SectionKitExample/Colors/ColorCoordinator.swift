import UIKit

struct ColorCoordinator: ColorNavigation {
    private unowned let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func show(color: UIColor) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        navigationController.pushViewController(viewController, animated: true)
    }
}
