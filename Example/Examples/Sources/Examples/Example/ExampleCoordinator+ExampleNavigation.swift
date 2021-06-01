import UIKit

extension ExampleCoordinator: ExampleNavigation {
    internal func showDetail() {
        nextCoordinator().present(segue: .push(onto: navigationController))
    }
}
