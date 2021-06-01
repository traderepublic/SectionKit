import UIKit
import Utilities

open class MockPresentable: Presentable {
    public enum Event: Equatable {
        case present(segue: NavigationSegue)
    }

    open var events: [Event] = []

    private let viewControllerToPresent: UIViewController

    public init(viewControllerToPresent: UIViewController) {
        self.viewControllerToPresent = viewControllerToPresent
    }

    @discardableResult
    open func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        events.append(.present(segue: segue))
        return segue.invoke(with: viewControllerToPresent)
    }
}
