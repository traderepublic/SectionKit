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
                        description: "A SingleSectionCollectionViewAdapter that shows a single ListSectionController.",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: ColorsCoordinator(navigationController: navigationController)
                        )
                    ),
                    ExampleViewModel(
                        name: "Numbers",
                        description: "A ListCollectionViewAdapter that shows multiple ListSectionController.",
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
                examples: [
                    ExampleViewModel(
                        name: "Emojis",
                        description: "A SingleSectionCollectionViewAdapter that shows a single ListSectionController."
                            + "It has a shuffle button and the ListSectionController is updated with a binding.",
                        navigation: ExampleCoordinator(
                            navigationController: navigationController,
                            nextCoordinator: EmojisCoordinator(navigationController: navigationController)
                        )
                    )
                ]
            ),
        ])
        return ExampleListViewController(viewModel: viewModel)
    }

    @discardableResult
    public func present(segue: NavigationSegue) -> NavigationSegue.RewindAction {
        segue.invoke(with: makeViewController())
    }
}
