import UIKit

public protocol Presentable {
    @discardableResult
    func present(segue: NavigationSegue) -> NavigationSegue.RewindAction
}

public enum NavigationSegue {
    case push(onto: UINavigationController)
    case present(on: UIViewController)

    public enum RewindAction {
        case pop(navigationController: UINavigationController, to: UIViewController?)
        case dismiss(viewController: UIViewController)

        public func rewind() {
            switch self {
            case let .pop(navigationController: navigationController, to: viewController):
                if let viewController = viewController {
                    navigationController.popToViewController(viewController, animated: true)
                } else {
                    navigationController.setViewControllers([], animated: true)
                }

            case let .dismiss(viewController: viewController):
                viewController.dismiss(animated: true)
            }
        }
    }

    @discardableResult
    public func invoke(with viewController: UIViewController) -> RewindAction {
        switch self {
        case let .push(onto: navigationController):
            let topViewController = navigationController.topViewController
            navigationController.pushViewController(viewController, animated: true)
            return .pop(navigationController: navigationController, to: topViewController)

        case let .present(on: presentingViewController):
            presentingViewController.present(viewController, animated: true)
            return .dismiss(viewController: viewController)
        }
    }
}
