import Examples
import UIKit

internal final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    internal var window: UIWindow?

    internal func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard window == nil else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        let coordinator = ExampleListCoordinator(navigationController: navigationController)
        coordinator.push(onto: navigationController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
