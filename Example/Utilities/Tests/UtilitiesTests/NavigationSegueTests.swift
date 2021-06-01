import TestUtilities
@testable import Utilities
import XCTest

final class NavigationSegueTests: XCTestCase {
    func testInvokePushCasePushesOntoNavigationController() {
        let navigationController = MockNavigationController()
        let pushSegue = NavigationSegue.push(onto: navigationController)
        let viewControllerToPush = UIViewController()
        pushSegue.invoke(with: viewControllerToPush)
        XCTAssertEqual(
            navigationController.events,
            [.pushViewController(viewController: viewControllerToPush, animated: true)]
        )
    }

    func testInvokePresentCasePresentsOnViewController() {
        let viewController = MockViewController()
        let presentSegue = NavigationSegue.present(on: viewController)
        let viewControllerToPresent = UIViewController()
        presentSegue.invoke(with: viewControllerToPresent)
        XCTAssertEqual(
            viewController.events,
            [.present(viewControllerToPresent: viewControllerToPresent, animated: true)]
        )
    }

    func testRewindPushCaseSetsViewControllersEmptyIfItWasEmptyBefore() {
        let navigationController = MockNavigationController()
        let pushSegue = NavigationSegue.push(onto: navigationController)
        let viewControllerToPush = UIViewController()
        let rewind = pushSegue.invoke(with: viewControllerToPush)
        navigationController.events = []
        rewind.rewind()
        XCTAssertEqual(
            navigationController.events,
            [.setViewControllers(viewControllers: [], animated: true)]
        )
    }

    func testRewindPushCasePopsToPreviousViewController() {
        let previousViewController = UIViewController()
        let navigationController = MockNavigationController(rootViewController: previousViewController)
        let pushSegue = NavigationSegue.push(onto: navigationController)
        let viewControllerToPush = UIViewController()
        let rewind = pushSegue.invoke(with: viewControllerToPush)
        navigationController.events = []
        rewind.rewind()
        XCTAssertEqual(
            navigationController.events,
            [.popToViewController(viewController: previousViewController, animated: true)]
        )
    }

    func testRewindPresentCaseDismissesViewController() {
        let viewController = MockViewController()
        let presentSegue = NavigationSegue.present(on: viewController)
        let viewControllerToPresent = MockViewController()
        let rewind = presentSegue.invoke(with: viewControllerToPresent)
        rewind.rewind()
        XCTAssertEqual(
            viewControllerToPresent.events,
            [.dismiss(animated: true)]
        )
    }
}
