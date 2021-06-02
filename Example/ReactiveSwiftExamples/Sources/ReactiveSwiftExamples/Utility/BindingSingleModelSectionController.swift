import ReactiveSwift
import SectionKit

open class BindingSingleModelSectionController<
    Model
>: SingleModelSectionController<Model> {
    private var bindings: Disposable?

    deinit {
        bindings?.dispose()
    }

    open func bind() -> Disposable? {
        return nil
    }

    override open var collectionViewModel: Model {
        didSet {
            bindings?.dispose()
            bindings = bind()
        }
    }
}
