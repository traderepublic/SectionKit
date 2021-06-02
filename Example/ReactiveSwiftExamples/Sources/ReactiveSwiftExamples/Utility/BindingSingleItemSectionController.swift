import ReactiveSwift
import SectionKit

open class BindingSingleItemSectionController<
    Model,
    Item
>: SingleItemSectionController<Model, Item> {
    private var bindings: Disposable?

    deinit {
        bindings?.dispose()
    }

    open func bind() -> Disposable? {
        return nil
    }

    override open func shouldUpdateItem(afterModelChangedTo model: Model) -> Bool {
        bindings?.dispose()
        bindings = bind()
        return false
    }
}
