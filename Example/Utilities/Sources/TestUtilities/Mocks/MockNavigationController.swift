import UIKit

open class MockNavigationController: UINavigationController {
    public enum Event: Equatable {
        case topViewController(UIViewController?)
        case pushViewController(viewController: UIViewController, animated: Bool)
        case popToViewController(viewController: UIViewController, animated: Bool)
        case setViewControllers(viewControllers: [UIViewController], animated: Bool)
    }

    open var events: [Event] = []

    private var _viewControllers: [UIViewController] = []

    override open var topViewController: UIViewController? {
        get { viewControllers.last }
    }

    override open var viewControllers: [UIViewController] {
        get { _viewControllers }
        set { _viewControllers = newValue }
    }

    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        events.append(.pushViewController(viewController: viewController, animated: animated))
        viewControllers.append(viewController)
    }

    override open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        events.append(.popToViewController(viewController: viewController, animated: animated))
        var result: [UIViewController] = []
        while let topViewController = topViewController, topViewController !== viewController {
            viewControllers = viewControllers.dropLast()
            result.append(topViewController)
        }
        return result
    }

    override open func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        events.append(.setViewControllers(viewControllers: viewControllers, animated: animated))
        self.viewControllers = viewControllers
    }
}
