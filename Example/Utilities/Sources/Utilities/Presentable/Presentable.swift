import UIKit

public protocol Presentable {
    @discardableResult
    func present(segue: NavigationSegue) -> NavigationSegue.RewindAction
}

extension Presentable {
    @inlinable
    @discardableResult
    public func push(onto navigationController: UINavigationController) -> NavigationSegue.RewindAction {
        present(segue: .push(onto: navigationController))
    }

    @inlinable
    @discardableResult
    public func present(on viewController: UIViewController) -> NavigationSegue.RewindAction {
        present(segue: .present(on: viewController))
    }
}

extension UIViewController: Presentable {
    @inlinable
    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: self)
    }
}
