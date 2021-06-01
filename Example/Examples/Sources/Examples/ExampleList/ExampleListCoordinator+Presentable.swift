import ReactiveSwiftExamples
import UIKit
import Utilities
import VanillaSwiftExamples

extension ExampleListCoordinator: Presentable {
    private func makeViewController() -> UIViewController {
        let navigationController = self.navigationController
        let viewModel = ExampleListViewModel(sections: [
            ExampleSectionViewModel(
                sectionId: .vanillaSwift,
                header: "Swift",
                footer: nil,
                examples: [
                    ExampleViewModel(
                        name: "Colors",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: ColorsCoordinator(navigationController: navigationController)
                        )
                    ),
                    ExampleViewModel(
                        name: "Numbers",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: NumbersCoordinator(navigationController: navigationController)
                        )
                    )
                ]
            ),
            ExampleSectionViewModel(
                sectionId: .reactiveSwift,
                header: "ReactiveSwift",
                footer: "https://github.com/ReactiveCocoa/ReactiveSwift",
                examples: []
            ),
        ])
        return ExampleListViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
