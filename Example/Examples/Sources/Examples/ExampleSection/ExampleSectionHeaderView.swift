import UIKit
import Utilities

internal final class ExampleSectionHeaderView: LabelSupplementaryView {
    internal func configure(with section: ExampleSectionViewModelType) {
        label.text = section.header
    }
}
