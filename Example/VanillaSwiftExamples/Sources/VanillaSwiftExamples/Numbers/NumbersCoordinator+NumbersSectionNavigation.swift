import UIKit

extension NumbersCoordinator: NumbersSectionNavigation {
    func show(number: Int) {
        let alertController = UIAlertController(
            title: "Number selected",
            message: "You selected \(number)",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        navigationController.present(alertController, animated: true)
    }
}
