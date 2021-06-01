import UIKit

open class MockViewController: UIViewController {
    public enum Event: Equatable {
        case present(viewControllerToPresent: UIViewController, animated: Bool)
        case dismiss(animated: Bool)
    }

    open var events: [Event] = []

    override open func present(
        _ viewControllerToPresent: UIViewController,
        animated flag: Bool,
        completion: (() -> Void)? = nil
    ) {
        events.append(.present(viewControllerToPresent: viewControllerToPresent, animated: flag))
        completion?()
    }

    open override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        events.append(.dismiss(animated: flag))
        completion?()
    }
}
