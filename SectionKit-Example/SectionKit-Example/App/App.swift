import UIKit

struct App {
    static func show(in window: UIWindow) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear

        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        let portfolio = UINavigationController(rootViewController: profileViewController)
        portfolio.navigationBar.standardAppearance = navBarAppearance
        portfolio.navigationBar.compactAppearance = navBarAppearance
        portfolio.navigationBar.scrollEdgeAppearance = navBarAppearance
        window.rootViewController = portfolio
        window.makeKeyAndVisible()
    }
}
