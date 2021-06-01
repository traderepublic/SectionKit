import UIKit

public struct NumbersCoordinator {
    unowned let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
