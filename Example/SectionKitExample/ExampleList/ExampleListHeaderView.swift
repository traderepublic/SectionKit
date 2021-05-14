import UIKit

final class ExampleListHeaderView: LabelSupplementaryView {
    func configure(with section: ExampleListSectionViewModelType) {
        label.text = section.header
    }
}
