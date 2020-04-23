import Foundation
import SectionKit
import ReactiveSwift

public extension Reactive where Base: GenericSectionControllerProtocol {
    var items: BindingTarget<[Base.Item]> {
        makeBindingTarget { base, items in
            base.items = items
        }
    }
}
