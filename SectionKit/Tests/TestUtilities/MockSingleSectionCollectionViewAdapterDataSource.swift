import SectionKit

internal class MockSingleSectionCollectionViewAdapterDataSource: SingleSectionCollectionViewAdapterDataSource {
    internal var _section: (CollectionViewAdapter) -> Section?

    internal init(section: @escaping (CollectionViewAdapter) -> Section?) {
        _section = section
    }

    internal func section(for adapter: CollectionViewAdapter) -> Section? {
        _section(adapter)
    }
}
