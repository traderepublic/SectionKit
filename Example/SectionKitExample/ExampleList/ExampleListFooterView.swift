import UIKit

final class ExampleListFooterView: LabelSupplementaryView {
    func configure(with section: ExampleListSectionViewModelType) {
        label.text = section.footer
    }
}
