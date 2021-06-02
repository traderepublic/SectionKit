import ReactiveSwift
import SectionKit

open class BindingListSectionController<
    Model,
    Item: Hashable
>: FoundationDiffingListSectionController<Model, Item> {
    private var bindings: Disposable?

    deinit { bindings?.dispose() }

    open func bind() -> Disposable? { nil }

    override open func shouldUpdateItems(afterModelChangedTo model: Model) -> Bool {
        bindings?.dispose()
        bindings = bind()
        return false
    }
}
