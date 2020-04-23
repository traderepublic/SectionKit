import UIKit

struct App {
    static func show(in window: UIWindow) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.shadowColor = .clear

        let portfolioVM = PortfolioViewModel()
        let portfolioVC = PortfolioViewController(viewModel: portfolioVM)
        portfolioVC.title = "Portfolio"
        let portfolio = UINavigationController(rootViewController: portfolioVC)
        portfolio.navigationBar.standardAppearance = navBarAppearance
        portfolio.navigationBar.compactAppearance = navBarAppearance
        portfolio.navigationBar.scrollEdgeAppearance = navBarAppearance
        window.rootViewController = portfolio
        window.makeKeyAndVisible()
    }
}
