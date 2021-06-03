import UIKit
import Utilities

internal final class ExampleSectionFooterView: LabelSupplementaryView {
    internal func configure(with section: ExampleSectionViewModelType) {
        label.text = section.footer
    }
}
