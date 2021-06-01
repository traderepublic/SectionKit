import UIKit

extension ColorsCoordinator: ColorsNavigation {
    internal func show(color: UIColor) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        navigationController.pushViewController(viewController, animated: true)
    }
}
