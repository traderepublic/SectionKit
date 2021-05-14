import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard window == nil else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navigationController = UINavigationController()
        let coordinator = ExampleListCoordinator(navigationController: navigationController)
        coordinator.present(segue: .push(onto: navigationController))

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
