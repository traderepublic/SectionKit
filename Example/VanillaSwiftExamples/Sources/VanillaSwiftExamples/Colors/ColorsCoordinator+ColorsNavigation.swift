import UIKit

extension ColorsCoordinator: ColorsNavigation {
    func show(color: UIColor) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = color
        navigationController.pushViewController(viewController, animated: true)
    }
}
