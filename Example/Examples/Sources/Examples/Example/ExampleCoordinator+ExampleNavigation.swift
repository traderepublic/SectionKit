import UIKit

extension ExampleCoordinator: ExampleNavigation {
    internal func showDetail() {
        presentable().push(onto: navigationController)
    }
}
