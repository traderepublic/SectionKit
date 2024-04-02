import UIKit

extension NamesCoordinator: NamesSectionNavigation {
    func show(name: String) {
        let alertController = UIAlertController(
            title: "Someone being choosed",
            message: "Amazing \(name) is nominated!",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alertController, animated: true)
    }
}
