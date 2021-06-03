import TestUtilities
@testable import Utilities
import XCTest

final class PresentableExtensionsTests: XCTestCase {
    func testPushInvokesPresentWithPushCase() {
        let navigationController = MockNavigationController()
        let viewControllerToPresent = UIViewController()
        let presentable = MockPresentable(viewControllerToPresent: viewControllerToPresent)
        let pushSegue = NavigationSegue.push(onto: navigationController)
        presentable.present(segue: pushSegue)
        XCTAssertEqual(presentable.events, [.present(segue: pushSegue)])
    }

    func testPresentInvokesPresentWithPresentCase() {
        let viewController = MockViewController()
        let viewControllerToPresent = UIViewController()
        let presentable = MockPresentable(viewControllerToPresent: viewControllerToPresent)
        let presentSegue = NavigationSegue.present(on: viewController)
        presentable.present(segue: presentSegue)
        XCTAssertEqual(presentable.events, [.present(segue: presentSegue)])
    }
}
