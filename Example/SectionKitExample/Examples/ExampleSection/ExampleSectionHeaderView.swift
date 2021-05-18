import UIKit

final class ExampleSectionHeaderView: LabelSupplementaryView {
    func configure(with section: ExampleSectionViewModelType) {
        label.text = section.header
    }
}
