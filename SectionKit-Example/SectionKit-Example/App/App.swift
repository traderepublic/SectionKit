import UIKit

struct App {
    static func show(in window: UIWindow) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear

        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        let profile = UINavigationController(rootViewController: profileViewController)
        profile.navigationBar.standardAppearance = navBarAppearance
        profile.navigationBar.compactAppearance = navBarAppearance
        profile.navigationBar.scrollEdgeAppearance = navBarAppearance
        profile.navigationBar.prefersLargeTitles = true
        profile.title = profileViewModel.output.title
        window.rootViewController = profile
        window.makeKeyAndVisible()
    }
}
