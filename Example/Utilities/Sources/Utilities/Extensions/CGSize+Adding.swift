import UIKit

extension CGSize {
    @inlinable
    public func adding(padding: NSDirectionalEdgeInsets) -> CGSize {
        CGSize(
            width: width + padding.leading + padding.trailing,
            height: height + padding.top + padding.bottom
        )
    }
}
