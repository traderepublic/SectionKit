import UIKit

extension ExampleCoordinator: ExampleNavigation {
    internal func showDetail() {
        nextCoordinator().push(onto: navigationController)
    }
}
