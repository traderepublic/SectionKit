import UIKit

extension ExampleListCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let viewModel = ExampleListViewModel(sections: [
            ExampleListSectionViewModel(
                sectionId: .vanillaSwift,
                header: "Swift",
                footer: nil,
                examples: [
                    ExampleViewModel(
                        name: "Colors",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: ColorCoordinator(navigationController: navigationController)
                        )
                    )
                ]
            ),
            ExampleListSectionViewModel(
                sectionId: .reactiveSwift,
                header: "ReactiveSwift",
                footer: "https://github.com/ReactiveCocoa/ReactiveSwift",
                examples: [
                    ExampleViewModel(
                        name: "Colors",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: ColorCoordinator(navigationController: navigationController)
                        )
                    )
                ]
            ),
        ])
        return ExampleListViewController(viewModel: viewModel)
    }

    @discardableResult
    func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
