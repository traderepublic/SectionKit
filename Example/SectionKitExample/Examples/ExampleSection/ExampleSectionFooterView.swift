import UIKit

final class ExampleSectionFooterView: LabelSupplementaryView {
    func configure(with section: ExampleSectionViewModelType) {
        label.text = section.footer
    }
}
